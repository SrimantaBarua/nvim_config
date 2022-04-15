local lsp = {}

-- Configure language servers I want to use
function lsp.configure()
  local lspconfig = require("lspconfig")

  -- Bash - `npm i -g bash-language-server`
  lspconfig.bashls.setup{}

  -- Clangd for C++ - install via package manager
  lspconfig.clangd.setup{}

  -- CMake - `pip install cmake-language-server`
  lspconfig.cmake.setup{
    buildDirectory = "build"
  }

  -- Pylsp for python - `pip install python-lsp-server`
  lspconfig.pylsp.setup{}

  -- rust_analyzer for Rust - install via package manager
  lspconfig.rust_analyzer.setup{}

  -- Lua. `brew install lua-language-server` on Mac. On linux, I'll have to do this -
  -- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  lspconfig.sumneko_lua.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',  -- Tell the language server we're using LuaJIT
          path = runtime_path, -- Setup Lua path
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  -- tsserver for Typescript
  lspconfig.tsserver.setup{}
end

return lsp
