local M = {}

local ns = vim.api.nvim_create_namespace('barua-colorizer')
local ts = vim.treesitter

local color_map = {}

local b_hash = string.byte('#')
local hex_bytes = {}

-- Initialize table of hex byte to character mapping. Lowercase characters are added as is
for _, c in ipairs({ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' }) do
  hex_bytes[string.byte(c)] = c
end
-- Uppercase characters are mapped to lowercase
for c in ipairs({ 'A', 'B', 'C', 'D', 'E', 'F' }) do
  hex_bytes[string.byte(c)] = string.lower(c)
end


-- Gets an iterator over comment and string nodes using treesitter
local function get_valid_nodes(bufnr)
  local parser = vim.treesitter.get_parser(bufnr)
  local tstree = parser:parse()[1]
  local root = tstree:root()
  local start_row, _, end_row, _ = root:range()
  local query = ts.parse_query(vim.bo.filetype, '[(comment) (string)] @item')
  local iter = query:iter_captures(root, 0, start_row, end_row)
  return function()
    for _, node in iter do return node:range() end
  end
end

-- Parse a line of text for highlight opportunities and apply them. All column and row values are
-- 0-indexed
local function highlight_line(bufnr, line, row, start_col, end_col)
  local i = 1
  while i <= end_col do
    if line:byte(i) == b_hash then
      i = i + 1
      local start = start_col + i
      local is_valid = true
      -- Check if the next 6 characters are hex
      for _ = 0, 5 do
        if i > end_col or hex_bytes[line:byte(i)] == nil then
          is_valid = false
          break
        else i = i + 1 end
      end
      if is_valid then
        -- This is a valid hex str
        local hexstr = line:sub(i - 6, i - 1)
        local color = color_map[hexstr]
        if color == nil then
          -- This is a new color. Generate a highlight and apply it, and also cache it
          color = 'BaruaColorizer_' .. hexstr
          vim.api.nvim_command('highlight ' .. color .. ' guibg=#' .. hexstr)
          color_map[hexstr] = color
        end
        -- Apply this highlight
        vim.api.nvim_buf_add_highlight(bufnr, ns, color, row, start - 2, start + 5)
      end
    else i = i + 1 end
  end
end

function M.colorize_buffer(bufnr)
  print("HERE")
  bufnr = bufnr or 0
  -- Clear any previous highlights we've set
  M.clear_highlights(bufnr)
  -- Get ranges for all valid nodes
  for start_row, start_column, end_row, end_column in get_valid_nodes(bufnr) do
    -- Get text data for those nodes
    local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_column, end_row, end_column, {})
    -- Go over each line and highlight it
    for i, line in ipairs(lines) do
      local end_col = end_column
      if start_row + i - 1 ~= end_row then
        end_col = string.len(line)
      end
      -- An optimization - only consider lines >= 7 characters long
      if end_col - start_column >= 7 then
        highlight_line(bufnr, line, start_row + i - 1, start_column, end_col)
      end
      start_column = 0
    end
  end
end

function M.clear_highlights(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

return M
