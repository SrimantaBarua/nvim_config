require('barua.settings')
require('packages')
require('barua.tree-sitter').configure()
require('barua.lsp').configure()
require('barua.completion').configure()
require('barua.telescope').configure()
require('barua.keybindings').setup_default()

-- Set color scheme
require('barua.themes').set_theme('black')

-- Configure norcalli's nvim-colorizer.lua
require('colorizer').setup {
  'css', 'lua'
}
