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
for _, c in ipairs({ 'A', 'B', 'C', 'D', 'E', 'F' }) do
  hex_bytes[string.byte(c)] = string.lower(c)
end

-- Convert hex string to RGB color
function M.hex_to_rgb(hexstr)
  local r = tonumber(hexstr:sub(1, 2), 16) / 255
  local g = tonumber(hexstr:sub(3, 4), 16) / 255
  local b = tonumber(hexstr:sub(5, 6), 16) / 255
  return r, g, b
end

-- Convert RGB to hex string
function M.rgb_to_hex(r, g, b)
  r = math.floor(r * 255 + 0.5)
  g = math.floor(g * 255 + 0.5)
  b = math.floor(b * 255 + 0.5)
  return string.format("%02x%02x%02x", r, g, b)
end

-- Convert RGB color to HSL. Adapted from https://stackoverflow.com/a/37657940
function M.rgb_to_hsl(r, g, b)
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local l = (max + min) / 2
  if max == min then return 0, 0, l end  -- Achromatic
  local h, s
  local d = max - min
  if l > 0.5 then s = d / (2 - max - min) else s = d / (max + min) end
  if max == r then
    h = 1.0472 * (g - b) / d
    if g < b then h = h + 6.2832 end
  elseif max == g then
    h = 1.0472 * (b - r) / d + 2.0944
  else -- max == b
    h = 1.0472 * (r - g) / d + 4.1888
  end
  h = h / 6.2832
  return h, s, l
end

local function hue_to_rgb(p, q, t)
  if t < 0 then t = t + 1 elseif t > 1 then t = t - 1 end
  if t < 1/6 then return p + (q - p) * 6 * t end
  if t < 1/2 then return q end
  if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
  return p
end

-- Convert HSL to RGB
function M.hsl_to_rgb(h, s, l)
  if s == 0 then return l, l, l end  -- Achromatic
  local q
  if l < 0.5 then q = l * (1 + s) else q = l + s - l * s end
  local p = 2 * l - q
  local r = hue_to_rgb(p, q, h + 1/3)
  local g = hue_to_rgb(p, q, h)
  local b = hue_to_rgb(p, q, h - 1/3)
  return r, g, b
end

-- Get the opposite color. Steps -
-- 1. Parse hex string to RGB
-- 2. Convert color to HSL
-- 3. Change hue to the opposite (turn it 180 degrees)
-- 4. Convert back to RGB
function M.get_opposite_color(hexstr)
  local r, g, b = M.hex_to_rgb(hexstr)
  local h, s, l = M.rgb_to_hsl(r, g, b)
  if s == 0 then
    r, g, b = 1 - l, 1 - l, 1 - l
  else
    if h > 0.5 then h = h - 0.5 else h = h + 0.5 end  -- Flip hue
    r, g, b = M.hsl_to_rgb(h, s, l)
  end
  local flipped_hexstr = M.rgb_to_hex(r, g, b)
  return flipped_hexstr
end

local function get_foreground_for_background(hexstr)
  local r, g, b = M.hex_to_rgb(hexstr)
  local _, _, l = M.rgb_to_hsl(r, g, b)
  if l <= 0.5 then
    return "ffffff"
  else
    return "000000"
  end
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
      local hexstr = ""
      -- Check if the next 6 characters are hex
      for _ = 0, 5 do
        if i > end_col or hex_bytes[line:byte(i)] == nil then
          is_valid = false
          break
        else
          hexstr = hexstr .. hex_bytes[line:byte(i)]
          i = i + 1
        end
      end
      if is_valid then
        -- This is a valid hex str
        local color = color_map[hexstr]
        if color == nil then
          -- This is a new color. Generate a highlight and apply it, and also cache it
          color = 'BaruaColorizer_' .. hexstr
          --local opposite = M.get_opposite_color(hexstr)
          local foreground = get_foreground_for_background(hexstr)
          vim.api.nvim_command('highlight ' .. color .. ' guibg=#' .. hexstr .. ' guifg=#' .. foreground)
          color_map[hexstr] = color
        end
        -- Apply this highlight
        vim.api.nvim_buf_add_highlight(bufnr, ns, color, row, start - 2, start + 5)
      end
    else i = i + 1 end
  end
end

function M.colorize_buffer(bufnr)
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
  bufnr = bufnr or 0
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

return M
