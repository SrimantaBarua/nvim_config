local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'bashls',
    'clangd',
    'pylsp',
    'rust_analyzer',
    'kotlin_language_server',
    'sumneko_lua',
    'tsserver',
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<CR>'] = nil
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil


-- Make nvim-autopairs work with cmp
-- Source - https://github.com/windwp/nvim-autopairs
cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
)

local kind_map = {
    Text = ' ',
    Method = ' ',
    Function = ' ',
    Constructor = ' ',
    Field = 'ﰠ ',
    Variable = ' ',
    Class = 'ﴯ ',
    Interface = ' ',
    Module = ' ',
    Property = 'ﰠ ',
    Unit = '塞 ',
    Value = ' ',
    Enum = ' ',
    Keyword = ' ',
    Snippet = ' ',
    Color = ' ',
    File = ' ',
    Reference = ' ',
    Folder = ' ',
    EnumMember = ' ',
    Constant = ' ',
    Struct = 'פּ ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = '<T> '
}

local menu_icon = {
    nvim_lsp = 'λ ',
    luasnip = '⋗ ',
    buffer = 'Ω ',
    path = '/ ',
    nvim_lua = 'Π ',
}

lsp.setup_nvim_cmp({
    formatting = {
        fields = {'menu', 'abbr', 'kind'},

        format = function(entry, item)
            local kind = kind_map[item.kind]
            if kind ~= nil then
                item.kind = kind
            end
            item.menu = menu_icon[entry.source.name]
            return item
        end
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
    local wk = require('which-key')

    wk.register({
        ['<leader>l'] = {
            name = 'lsp',
            d = { vim.lsp.buf.definition, 'definition', buffer = bufnr },
            D = {
                name = 'diagnostic',
                n = { vim.diagnostic.goto_next, 'next', buffer = bufnr },
                o = { vim.diagnostic.open_float, 'open', buffer = bufnr },
                p = { vim.diagnostic.goto_prev, 'previous', buffer = bufnr },
            },
            f = { vim.lsp.buf.format, 'format', buffer = bufnr },
            r = { vim.lsp.buf.references, 'references', buffer = bufnr },
            R = { vim.lsp.buf.rename, 'rename', buffer = bufnr },
            ['ws'] = { vim.lsp.buf.workspace_symbol, 'workspace symbol', buffer = bufnr },
            ['va'] = { vim.lsp.buf.code_action, 'code action', buffer = bufnr },
            ['vd'] = { vim.diagnostic.open_float, 'diagnostics', buffer = bufnr },
        },
        ['K'] = { vim.lsp.buf.hover, 'lsp: hover', buffer = bufnr },
        ['<C-h>'] = { vim.lsp.buf.signature_help, 'lsp: signature', buffer = bufnr },
    })
end)

-- Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- Set up lsp-lines
require('lsp_lines').setup()

-- Disable regular virtual text diagnostics since I have lsp-lines now
vim.diagnostic.config({
    virtual_text = false,
})
