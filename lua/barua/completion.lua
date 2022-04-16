local completion = {}

-- Get LSP client capabilities
function completion.capabilities()
  local default_capabilities = vim.lsp.protocol.make_client_capabilities()
  return require('cmp_nvim_lsp').update_capabilities(default_capabilities)
end

-- Configure completion
function completion.configure()
  local cmp = require('cmp')

  local kind_map = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '塞',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = '<T>'
  }

  cmp.setup ({
    snippet = {
      expand = function(args) vim.fn['UltiSnips#Anon'](args.body) end
    },
    -- Keybindings for when completion window is active
    mapping = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping.select_prev_item(),
      ['<C-p>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-1),
      ['<C-f>'] = cmp.mapping.scroll_docs(1),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true })
    }),
    -- Completion sources in order of preferences in "groups"
    sources = cmp.config.sources(
      { -- group 1
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'path' }
      },
      { -- group 2
        { name = 'buffer' }
      }
    ),
    -- Return custom "kind" - the stuff that appears to the side
    formatting = {
      format = function(_, vim_item)
        local kind = kind_map[vim_item.kind]
        if kind ~= nil then
          vim_item.kind = kind
        end
        return vim_item
      end
    }
  })
end

return completion