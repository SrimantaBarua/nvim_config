vim.g.mapleader      = " "
vim.g.maplocalleader = ","

-- Setup lazy.nvim for package management
-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from a module
require("lazy").setup("barua.plugins")

-- Load my config
require("barua.settings")

-- Set color scheme
vim.cmd.colorscheme "catppuccin-mocha"
