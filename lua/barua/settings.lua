vim.opt.hlsearch      = true       -- Keep search results highlighted
vim.opt.incsearch     = true       -- Incremental search
vim.opt.inccommand    = "nosplit"  -- Incremental commands show results in the buffer
vim.opt.expandtab     = true       -- Use spaces for indentation
vim.opt.shiftwidth    = 4          -- Indent with 4 spaces
vim.opt.softtabstop   = 4          -- Inserting a tab looks like 4 spaces
vim.opt.tabstop       = 8          -- A tab is 8 spaces (default)
vim.opt.autoindent    = true       -- Coyp indent from current line when starting a new line
vim.opt.smartindent   = true       -- Smart indent for C-like languages
vim.opt.swapfile      = false
vim.opt.backup        = false
vim.opt.undodir       = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile      = true
vim.opt.completeopt   = "menu,menuone"
vim.opt.hidden        = true
vim.opt.joinspaces    = false
vim.opt.termguicolors = true       -- Enable 24-bit RGB color
vim.opt.cursorline    = true
vim.opt.colorcolumn   = "100"
