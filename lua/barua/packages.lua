-- Use packer for package management
-- https://github.com/wbthomason/packer.nvim

return require('packer').startup(function(use)
  -- Use packer to manage itself
  use 'wbthomason/packer.nvim'

  -- Install the treesitter plugin and update grammars post-install
  use { 'nvim-treesitter/playground' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Install nvim-lspconfig for easy configuration of language servers
  use { 'neovim/nvim-lspconfig', requires = { 'hrsh7th/cmp-nvim-lsp' }}

  -- Markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })


  -- Ultisnips for snippets
  use 'SirVer/ultisnips'

  -- Automatic pair completion
  use 'windwp/nvim-autopairs'

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

  -- One-dark theme
  use 'navarasu/onedark.nvim'

  -- Lualine for statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

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
