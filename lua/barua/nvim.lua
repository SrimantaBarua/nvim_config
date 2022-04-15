local nvim = {}

-- Metatable for syntactic sugar
nvim.mt = {}

-- Get neovim configuration value
nvim.mt.__index = function (table, key)
  return vim.api.nvim_get_var(key)
end

-- Set neovim configuration value
nvim.mt.__newindex = function (table, key, value)
  return vim.api.nvim_set_var(key, value)
end

-- Run neovim command
function nvim.command(command)
  vim.api.nvim_command(command)
end

setmetatable(nvim, nvim.mt)

return nvim
