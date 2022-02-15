local M = {}

M.configure = function()
  local opt = vim.opt

  opt.mouse = 'a'                -- Enable mouse support
  opt.expandtab = true           -- Use spaces by default instead of tabs
  opt.shiftwidth = 2             -- Size of an indent = 2
  opt.tabstop = 2                -- Number of spaces for tab = 2
  opt.number = true              -- Enable line numbers
  opt.hidden = true              -- Enable background buffers (do not unload invisible buffers)
  opt.joinspaces = false         -- No double spaces with join with '.' etc
  -- opt.list = true                -- Show some invisible characters
  opt.scrolloff = 2              -- Lines of context
  opt.wrap = false               -- Disable line wrap
  opt.sidescrolloff = 2          -- Columns of context
  opt.autoindent = true          -- This and next - indent automaticall
  opt.smartindent = true
  opt.termguicolors = true       -- Support truecolor
  opt.splitbelow = true          -- New windows go below the current one
  opt.splitright = true          -- New windows go to the right of the current one
  opt.cursorline = true          -- Highlight the current cursor line
  opt.signcolumn = 'yes'         -- Always enable signcolumn so that stuff doesn't keep moving
  opt.colorcolumn = '100'        -- Have a vertical line on column 100
  opt.clipboard = 'unnamedplus'  -- Use the system clipboard
  opt.inccommand = 'nosplit'     -- Show incremental output of replacments etc
end

return M
