require('barua.settings')
require('barua.packages')
require('barua.tree-sitter').configure()
require('barua.lsp').configure()
require('barua.completion').configure()
require('barua.telescope').configure()
require('barua.keybindings').setup_default()

-- Set color scheme
require('barua.theme')

-- Configure norcalli's nvim-colorizer.lua
require('colorizer').setup {
  'css', 'lua'
}
