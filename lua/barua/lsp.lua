--[[
    Setup specific to LSP in neovim
]]

local M = {}

-- Configurations I want to apply for all LSP servers
local lsp_server_configurations = {
    bashls = {},
    dockerls = {},
    kotlin_language_server = {},
    pyright = {},
    rust_analyzer = {},
    tsserver = {},
    lua_ls = {
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
    },
}

-- Setup mason, and mason-lspconfig. This has to happen before setting up lspconfig
local function setup_mason ()
    local all_servers = {}
    for k in pairs(lsp_server_configurations) do
        table.insert(all_servers, k)
    end

    require("mason").setup {}
    require("mason-lspconfig").setup {
        ensure_installed = all_servers,
    }
end

-- Callback to run on attaching LSP to a buffer
local autoformat_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function on_lsp_attach (client, bufnr)
    -- Format before save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = autoformat_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = autoformat_augroup,
            buffer = bufnr,
            callback = function() vim.lsp.buf.format() end,
        })
    end
end

-- Configure LSP servers with nvim-lspconfig
local function setup_lspconfig ()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    for k, v in pairs(lsp_server_configurations) do
        local opts = vim.tbl_extend("keep", v, {
            capabilities = capabilities,
            on_attach = on_lsp_attach
        })
        lspconfig[k].setup(opts)
    end
end

-- Setup mason, mason-lspconfig.nvim, and lspconfig, in that order
-- https://github.com/williamboman/mason-lspconfig.nvim
function M.setup_lsp ()
    setup_mason()
    setup_lspconfig()
end

-- Setup nvim-cmp
function M.setup_nvim_cmp ()
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function (args)
                -- Use snippy as my snippet engine
                require("snippy").expand_snippet(args.body)
            end
        },
        mapping = {
            -- Pick option
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            -- Documentation
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-q>'] = cmp.mapping.close_docs(),
            -- Close window
            ['<C-e>'] = cmp.mapping.close(),
            -- Confirm selection
            ['<C-y>'] = cmp.mapping.confirm {
                select = true,
                behavior = cmp.ConfirmBehavior.Insert
            },
            -- Invoke completion
            ['<C-spaace>'] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources({
            { name = "snippy" },
            { name = "nvim_lsp" },
            { name = "path" },
        }, {
            { name = "buffer", keyword_length = 5 },
        })
    })
end

return M
