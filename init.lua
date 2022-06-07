require('barua.settings')
require('barua.packages')
require('barua.tree-sitter').configure()
require('barua.lsp').configure()
require('barua.completion').configure()
require('barua.telescope').configure()
require('barua.keybindings').setup_default()

-- Set color scheme
require('onedark').setup { style = 'warmer' }
require('onedark').load()

-- Enable pair completion
require('nvim-autopairs').setup{}

-- Enable lualine
require('lualine').setup { options = { theme = 'onedark' } }
-- require('barua.theme')

-- Configure norcalli's nvim-colorizer.lua
require('colorizer').setup {
  'css', 'lua'
}
