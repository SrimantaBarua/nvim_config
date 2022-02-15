local M = {}

M.configure = function()
  local packer = require('packer')
  local use = packer.use

  packer.startup(function()
    -- Manage packer with packer
    use 'wbthomason/packer.nvim'

    -- Tree-sitter configuration
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function() require('config.treesitter').configure() end,
      event = 'BufRead',
      run = ':TSUpdate',
    }

    -- Syntax highlighting for Kitty configuration
    use 'fladson/vim-kitty'

    -- Colorize RGB etc strings in files
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup {
          'kitty'
      }
      end,
    }

    -- Language server protocol
    use {
      'kabouzeid/nvim-lspinstall',
      event = 'BufRead',
    }

    use {
      'neovim/nvim-lspconfig',
      after = 'nvim-lspinstall',
      config = function() require('config.lsp').configure() end,
    }

    -- Ultisnips for snippets
    use {
      'SirVer/ultisnips',
      event = 'BufEnter',
      -- config = function() require('config.ultisnips').configure() end,
    }

    -- Code completion
    use {
      'hrsh7th/nvim-compe',
      event = 'InsertEnter',
      config = function() require('config.compe').configure() end,
    }

    -- FZF for fuzzy search
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
  end)
end

return M
