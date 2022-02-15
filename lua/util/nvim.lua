-- Library of common Neovim Lua functions under a convenient-to-use namespace

local M = {}

M.command = function (command)
  vim.api.nvim_command(command)
end

-- Metatable for syntactic sugar
M.mt = {}

M.mt.__index = function (table, key)
  return vim.api.nvim_get_var(key)
end

M.mt.__newindex = function (table, key, value)
  return vim.api.nvim_set_var(key, value)
end

setmetatable(M, M.mt)
return M
