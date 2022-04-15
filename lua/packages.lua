-- Use packer for package management
-- https://github.com/wbthomason/packer.nvim

return require("packer").startup(function()
  -- Use packer to manage itself
  use 'wbthomason/packer.nvim'

  -- Install the treesitter plugin and update grammars post-install
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require("barua.tree-sitter").configure
  }

  -- Install tree-sitter playground so to help me write queries
  use {
    'neovim/nvim-lspconfig',
    config = require("barua.lsp").configure
  }
end)
