--[[
    External (dependency) programs
    - cmake
    - C compiler (gcc, clang)
    - git
    - tar
    - curl
    - fd - https://github.com/sharkdp/fd
    - rg - https://github.com/BurntSushi/ripgrep
]]

require("barua.startup")
require("barua.lazy")
require("barua.settings")
require("barua.keymaps")
require("barua.lsp").setup_lsp()
