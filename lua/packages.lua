-- Use packer for package management
-- https://github.com/wbthomason/packer.nvim

return require('packer').startup(function(use)
  -- Use packer to manage itself
  use 'wbthomason/packer.nvim'

  -- Install the treesitter plugin and update grammars post-install
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Install nvim-lspconfig for easy configuration of language servers
  use { 'neovim/nvim-lspconfig', requires = { 'hrsh7th/cmp-nvim-lsp' }}

  -- Ultisnips for snippets
  use 'SirVer/ultisnips'

  -- nvim-cmp for completion, though I'll try to write my own
  -- https://github.com/hrsh7th/nvim-cmp/
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lua', -- for Neovim Lua API
      'hrsh7th/cmp-nvim-lsp', -- for completion from LSP
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'quangnguyen30192/cmp-nvim-ultisnips'
    },
  }

  -- norcalli/nvim-colorizer.lua for colors in buffers - helps when building themes
  use 'norcalli/nvim-colorizer.lua'

  -- Telescope for fuzzy finding
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    -- External dependencies - ripgrep
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-symbols.nvim'
    },
  }

  -- Insert icons into stuff
  use 'kyazdani42/nvim-web-devicons'
end)
