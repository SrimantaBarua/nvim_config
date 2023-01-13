vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 2
vim.opt.wrap = false
vim.opt.sidescrolloff = 2

vim.opt.termguicolors = true
vim.opt.signcolumn = "no"

vim.opt.completeopt = "menu,menuone"
vim.opt.hidden = true
vim.opt.joinspaces = false
vim.opt.lazyredraw = true
vim.opt.updatetime = 50

vim.opt.cursorline = true
vim.opt.colorcolumn = "100"
