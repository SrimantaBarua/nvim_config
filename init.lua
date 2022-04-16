-- Configure default vim options
require("barua.settings")

-- Install packages
require("packages")

-- Set color scheme
require("barua.themes").set_theme("black")

-- Set up keybindings
require("barua.keybindings").setup_default()
