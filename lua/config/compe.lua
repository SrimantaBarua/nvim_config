local M = {}

M.configure = function()
  -- Enable menu even with one item, and do not select an entry on start
  vim.o.completeopt = 'menuone,noselect'

  require('compe').setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 220,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
      buffer = { kind = '-', true },
      luasnip = { kind = '-', true },
      nvim_lsp = true,
      nvim_lua = true,
      path = true,
      calc = true,
      ultisnips = true,
    }
  }
end

return M
