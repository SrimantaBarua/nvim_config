--[[
    Setup specific to LSP in neovim
]]

-- Setup mason, mason-lspconfig.nvim, and lspconfig, in that order
-- https://github.com/williamboman/mason-lspconfig.nvim

require("mason").setup {}

require("mason-lspconfig").setup {
    ensure_installed = {
        "bashls",
        "dockerls",
        "kotlin_language_server",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "tsserver",
    },
}

--[[
    Individual language servers
]]

-- Lua - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
require("lspconfig").lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}

require("lspconfig").rust_analyzer.setup {}

