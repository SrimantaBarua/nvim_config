local M = {}

local NAMESPACE = vim.api.nvim_create_namespace("BaruaPresentation")

-- Create highlights
local HL_H1          = "BaruaPresentH1"
local HL_H2          = "BaruaPresentH2"
local HL_H3          = "BaruaPresentH3"
local HL_INLINE_CODE = "BaruaPresentInlineCode"
local HL_CODE_BLOCK  = "BaruaPresentCodeBlock"

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

local block_types = { paragraph = 'p', code = 'c', block = 'b' }

local function render_block(block, level, lines, highlights)
  table.insert(lines, "")
  local prefix = string.rep(" ", level)
  if block.type == block_types.paragraph then
    -- TODO: Support inline code
    for _, line in ipairs(block.content) do
      table.insert(lines, prefix .. line)
    end
  elseif block.type == block_types.code then
    -- TODO: Support syntax highlighting
    -- local language = block.content.language
    local start_line, max_length = #lines, 0
    -- Calculate max length
    for _, line in ipairs(block.content.code) do
      max_length = math.max(max_length, #line)
    end
    max_length = max_length + 1
    -- Write lines out padded with spaces
    for _, line in ipairs(block.content.code) do
      table.insert(lines, prefix .. " " .. line .. string.rep(" ", max_length - #line))
    end
    max_length = max_length + level + 1
    local end_line = #lines
    -- Highlight those lines
    for i = start_line, end_line - 1 do
      local hl = { group = HL_CODE_BLOCK, line = i, col_start = level, col_end = max_length }
      table.insert(highlights, hl)
    end
  elseif block.type == block_types.block then
    local i = #lines
    local title_line = "  " .. string.rep("█", level) .. " " .. block.content.title
    local hl = string.format("BaruaPresentH%d", level)
    table.insert(lines, title_line)
    table.insert(highlights, { group = hl, line = i,  col_start = 2, col_end = #title_line })
    for _, child in ipairs(block.content.blocks) do
      render_block(child, level + 1, lines, highlights)
    end
  else
    print("invalid block type: " .. block.type)
  end
end

-- Construct a list of lines for the given slide
local function render_slide(slide)
  local lines, highlights = {}, {}
  table.insert(lines, "")
  table.insert(lines, "  █ " .. slide.title)
  table.insert(highlights, { group = HL_H1, line = 1,  col_start = 2, col_end = #lines[2] })
  -- Go over each block and render it
  if slide.blocks ~= nil then
    for _, block in ipairs(slide.blocks) do
      render_block(block, 2, lines, highlights)
    end
  end
  return lines, highlights
end

-- Given a slide definition, draw it in the provided buffer
local function draw_slide(bufnr, slide)
  local lines, highlights = render_slide(slide)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  for _, hl in ipairs(highlights) do
    --vim.pretty_print(hl)
    vim.api.nvim_buf_add_highlight(bufnr, NAMESPACE, hl.group, hl.line, hl.col_start, hl.col_end)
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
                "",
                "int main() {",
                "  return 0;",
                "}",
              }
            }
          }
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
