local M = {}

local NAMESPACE = vim.api.nvim_create_namespace("BaruaPresentation")

local ts_utils = require('nvim-treesitter.ts_utils')

local C_QUERY = [[
(preproc_include) @include
[(true) (false)] @boolean
(comment) @comment
]]

local RUST_QUERY = [[
]]

local QUERIES = {
  c = C_QUERY,
  rust = RUST_QUERY,
}

-- capture -> highlight
local TS_HL_GROUP = {
  include = "TSInclude",
  boolean = "TSBoolean",
  comment = "TSComment",
}

-- Create highlights
local HL_H1          = "BaruaPresentH1"
local HL_CODE_BLOCK  = "BaruaPresentCodeBlock"

local block_types = { paragraph = 'p', code = 'c', block = 'b' }

-- Slide format -
-- {
--   title = "string",
--   blocks = {
--     {
--       type = "string",
--       content = { "string" }         (for paragraph)
--       content = {                    (for code)
--         language = "string",
--         code = { "string" }
--       }
--       content = {                    (for block)
--         title = "string",
--         blocks = { ... }
--       }
--     }
--   }
-- }

-- Adds a highlight to a range in the buffer.
local function highlight(bufnr, group, line, col_start, col_end)
  vim.api.nvim_buf_add_highlight(bufnr, NAMESPACE, group, line, col_start, col_end)
end

-- Draws a paragraph block.
local function draw_paragraph(bufnr, content, level)
  local lines = { "" }
  local prefix = string.rep(" ", level)
  -- TODO: Support inline code
  for _, line in ipairs(content) do
    table.insert(lines, prefix .. line)
  end
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, true, lines)
end

-- Draws a code block. Only ASCII code supported for now.
local function draw_code_block(bufnr, content, level, code_blocks)
  local lines = { "" }
  local start_line = vim.api.nvim_buf_line_count(bufnr)
  local prefix = string.rep(" ", level + 1)
  -- Calculate max line length of code
  local max_length = 0
  for _, line in ipairs(content.code) do
    max_length = math.max(max_length, #line)
  end
  max_length = max_length + 1
  -- Write lines out padded with spaces
  for _, line in ipairs(content.code) do
    table.insert(lines, prefix .. line .. string.rep(" ", max_length - #line))
  end
  max_length = max_length + level + 1
  -- Write those lines to the buffer
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, true, lines)
  -- Highlight those lines
  local end_line = vim.api.nvim_buf_line_count(bufnr)
  -- Mark code block for future highlighting
  if code_blocks[content.language] == nil then
    code_blocks[content.language] = {}
  end
  local start_byte = vim.fn.line2byte(start_line)
  local end_byte = vim.fn.line2byte(end_line)
  table.insert(code_blocks[content.language], {{ start_line, 0, start_byte, end_line, 0, end_byte }})
  -- Highlight normally with lighter background
  for i = start_line, end_line - 1 do
    highlight(bufnr, HL_CODE_BLOCK, i, level, max_length)
  end
end

-- Draws a block in the slide definition.
local function draw_block(bufnr, block, level, code_blocks)
  if block.type == block_types.paragraph then
    draw_paragraph(bufnr, block.content, level)
  elseif block.type == block_types.code then
    draw_code_block(bufnr, block.content, level, code_blocks)
  elseif block.type == block_types.block then
    local lines = { "" }
    local start_line = vim.api.nvim_buf_line_count(bufnr)
    -- Write title string
    local title_line = "  " .. string.rep("█", level) .. " " .. block.content.title
    table.insert(lines, title_line)
    vim.api.nvim_buf_set_lines(bufnr, -1, -1, true, lines)
    highlight(bufnr, string.format("BaruaPresentH%d", level), start_line + 1, 2, #title_line)
    -- Draw child blocks
    for _, child in ipairs(block.content.blocks) do
      draw_block(bufnr, child, level + 1, code_blocks)
    end
  else
    print("invalid block type: " .. block.type)
  end
end

-- Highlights all code blocks for a language.
local function highlight_code_for_language(bufnr, language, ranges)
  print(language)
  vim.pretty_print(ranges)
  if QUERIES[language] == nil then
    print("Languge '" .. language .. "' not yet supported")
    return
  end
  local parser = vim.treesitter.get_parser(bufnr, language)
  vim.pretty_print(parser)
  local query = vim.treesitter.parse_query(language, QUERIES[language])
  parser:set_included_regions(ranges)
  local trees = parser:parse()
  for _, tree in ipairs(trees) do
    local root = tree:root()
    print(root:sexpr())
    local start_row, _, end_row, _ = root:range()
    for id, node in query:iter_captures(root, 0, start_row, end_row) do
      local name = query.captures[id]
      local group = TS_HL_GROUP[name]
      if group ~= nil then
        ts_utils.highlight_node(node, bufnr, NAMESPACE, group)
      end
    end
  end
end

-- Given a slide definition, draw it in the provided buffer
local function draw_slide(bufnr, slide)
  local code_blocks = {}
  local title_line = "  █ " .. slide.title
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, { "", title_line })
  highlight(bufnr, HL_H1, 1, 2, #title_line)
  -- Go over each block and draw it
  if slide.blocks ~= nil then
    for _, block in ipairs(slide.blocks) do
      draw_block(bufnr, block, 2, code_blocks)
    end
  end
  vim.pretty_print(code_blocks)
  -- Highlight all code blocks
  for language, ranges in pairs(code_blocks) do
    highlight_code_for_language(bufnr, language, ranges)
  end
end

local TEST_SLIDE = {
  title = "Hello, world!",
  blocks = {
    {
      type = block_types.block,
      content = {
        title = "Sub block",
        blocks = {
          {
            type = block_types.paragraph,
            content = {
              "This is a sample paragraph",
            },
          },
          {
            type = block_types.code,
            content = {
              language = "c",
              code = {
                "#include <stdio.h>",
                "struct Point { double x; double y; };",
                "int main(int argc, char *const argv) {",
                "  if (true) { printf(\"hello, world!\\n\"); }",
                "  return 0;",
                "}",
              }
            }
          },
          {
            type = block_types.code,
            content = {
              language = "rust",
              code = {
                "use std::collections::HashMap;",
                "trait Trait { }",
                "struct Test {",
                "  blah: HashMap<i32, Test>",
                "}",
                "impl Test {",
                "  fn foo(&self) -> bool { true }",
                "}",
                "impl Trait for Test { }",
                "fn main() {",
                "  if (true) {",
                "    println!(\"hello, world!\");",
                "  }",
                "}",
              }
            }
          },
          {
            type = block_types.block,
            content = {
              title = "Sub sub block",
              blocks = {
                {
                  type = block_types.paragraph,
                  content = {
                    "This is a sample paragraph",
                  },
                },
              },
            },
          },
        }
      }
    }
  }
}

local function testing()
  local current_buffer = vim.api.nvim_win_get_buf(0)
  local current_win = vim.api.nvim_get_current_win()
  local current_win_num = vim.api.nvim_win_get_option(current_win, 'number')
  local current_win_rel_num = vim.api.nvim_win_get_option(current_win, 'relativenumber')
  local laststatus = vim.o.laststatus
  -- Create a new unlisted scratch buffer
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buffer)
  -- Draw the slide in the test buffer
  draw_slide(buffer, TEST_SLIDE)
  -- Set a keybinding that restores the current buffer for the window
  vim.keymap.set('n', 'q', function()
    vim.api.nvim_win_set_option(current_win, 'number', current_win_num)
    vim.api.nvim_win_set_option(current_win, 'relativenumber', current_win_rel_num)
    vim.o.laststatus = laststatus
    vim.api.nvim_win_set_buf(current_win, current_buffer)
    vim.api.nvim_buf_delete(buffer, {})
  end, { buffer = buffer })
  -- Set this as the current buffer for the window
  -- vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
  vim.api.nvim_win_set_option(current_win, 'number', false)
  vim.api.nvim_win_set_option(current_win, 'relativenumber', false)
  vim.o.laststatus = 0
  vim.api.nvim_win_set_buf(current_win, buffer)
end

testing()

-- Returns a slice of an int-indexed table. `start` and `end` are 1-indexed and inclusive.
local function table_slice(table, first, last)
  local slice = {}
  for i = first, last do
    table.insert(slice, table[i])
  end
  return slice
end

function M.split_into_slides(bufnr)
  bufnr = bufnr or 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1)
  local slices = {}
  local start = 1
  for i, line in ipairs(lines) do
    if line == "===" then
      if i == start then
        table.insert(slices, {})
      else
        local slice = table_slice(start, i - 1)
        table.insert(slices, slice)
      end
      start = i + 1
    end
  end
end

return M
