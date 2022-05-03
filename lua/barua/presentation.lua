local M = {}

local NAMESPACE = vim.api.nvim_create_namespace("BaruaPresentation")

local ts_utils = require('nvim-treesitter.ts_utils')


--[[
(translation_unit (preproc_include path: (system_lib_string)) (struct_specifier name: (type_identifier) body: (field_declaration_list (field_declaration type: (primitive_type) declarator: (field_identifier)) (field_declaration type: (primitive_type) declarator: (field_identifier)))) (function_definition type: (primitive_type) declarator: (function_declarator declarator: (identifier) parameters: (parameter_list (parameter_declaration type: (primitive_type) declarator: (identifier)) (parameter_declaration type: (primitive_type) declarator: (pointer_declarator (type_qualifier) declarator: (identifier))))) body: (compound_statement (if_statement condition: (parenthesized_expression (true)) consequence: (compound_statement (expression_statement (call_expression function: (identifier) arguments: (argument_list (string_literal (escape_sequence))))))) (return_statement (number_literal)))))

(source_file (use_declaration argument: (scoped_identifier path: (scoped_identifier path: (identifier) name: (identifier)) name: (identifier))) (trait_item name: (type_identifier) body: (declaration_list)) (struct_item name: (type_identifier) body: (field_declaration_list (field_declaration name: (field_identifier) type: (generic_type type: (type_identifier) type_arguments: (type_arguments (primitive_type) (type_identifier)))))) (impl_item type: (type_identifier) body: (declaration_list (function_item name: (identifier) parameters: (parameters (self_parameter (self))) return_type: (primitive_type) body: (block (boolean_literal))))) (impl_item trait: (type_identifier) type: (type_identifier) body: (declaration_list)) (function_item name: (identifier) parameters: (parameters) body: (block (expression_statement (if_expression condition: (parenthesized_expression (boolean_literal)) consequence: (block (expression_statement (macro_invocation macro: (identifier) (token_tree (string_literal))))))))))
]]

local C_QUERY = [[
[(true) (false)] @boolean
(comment) @comment
(field_identifier) @field
(preproc_include) @include
[ "break" "continue" "do" "else" "for" "if" "return" "struct" "while" ] @keyword
[ "(" ")" "{" "}" ";" "," ] @punctuation
(type_identifier) @type
(primitive_type) @type_builtin
(function_declarator declarator: (identifier) @func)
(call_expression function: (identifier) @func)
(parameter_declaration declarator: (identifier) @parameter)
(string_literal) @string
(number_literal) @number
]]

local RUST_QUERY = [[
]]

local QUERIES = {
  c = C_QUERY,
  rust = RUST_QUERY,
}

-- capture -> highlight
local TS_HL_GROUP = {
  boolean      = "TSBoolean",
  comment      = "TSComment",
  field        = "TSField",
  func         = "TSFunction",
  include      = "TSInclude",
  keyword      = "TSKeyword",
  number       = "TSNumber",
  parameter    = "TSParameter",
  punctuation  = "TSPuncDelimiter",
  string       = "TSString",
  type         = "TSType",
  type_builtin = "TSTypeBuiltin",
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
  -- Concatenated code - will be used for highlighting
  local concat = ""
  -- Calculate max line length of code
  local max_length = 0
  for _, line in ipairs(content.code) do
    max_length = math.max(max_length, #line)
  end
  max_length = max_length + 1
  -- Write lines out padded with spaces
  for _, line in ipairs(content.code) do
    table.insert(lines, prefix .. line .. string.rep(" ", max_length - #line))
    concat = concat .. "\n" .. line
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
  table.insert(code_blocks[content.language], {
    start_line = start_line,
    left_offset = level + 1,
    code = concat,
  })
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
local function highlight_code_for_language(bufnr, language, opts)
  if QUERIES[language] == nil then
    print("Languge '" .. language .. "' not yet supported")
    return
  end
  for _, opt in ipairs(opts) do
    local parser = vim.treesitter.get_string_parser(opt.code, language)
    local query = vim.treesitter.parse_query(language, QUERIES[language])
    local trees = parser:parse()
    for _, tree in ipairs(trees) do
      local root = tree:root()
      print(root:sexpr())
      local root_start_row, _, root_end_row, _ = root:range()
      for id, node in query:iter_captures(root, 0, root_start_row, root_end_row) do
        local name = query.captures[id]
        local group = TS_HL_GROUP[name]
        print(name .. " : " .. group)
        if group ~= nil then
          local start_row, start_col, _, end_col = node:range()
          start_row = start_row + opt.start_line
          start_col = start_col + opt.left_offset
          end_col = end_col + opt.left_offset
          highlight(bufnr, group, start_row, start_col, end_col)
        end
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
  for language, opts in pairs(code_blocks) do
    highlight_code_for_language(bufnr, language, opts)
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
