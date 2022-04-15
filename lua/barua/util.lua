local util = {}

-- Gets the position of a mark in the buffer, and returns a table of the form -
-- { bufnum: int, line: int, column: int, offset: int }
function util.get_mark_position(mark)
  local position = vim.api.nvim_eval('getpos("' .. mark .. '")')
  local result = {
    bufnum = position[1],
    line = position[2],
    column = position[3],
    offset = position[4], -- used for 'virtualedit'
  }
  return result
end

-- Gets the bounds of the current selection (inclusive) in visual mode. Returns a table of the form
-- { first: Position, last: Position }
function util.get_current_selection()
  local result = {}
  result.first = M.get_mark_position("'<")
  result.last = M.get_mark_position("'>")
  return result
end

-- Reload this module
function util.reload_module(module)
  package.loaded[module] = nil
  require(module)
end

return util
