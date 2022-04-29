local keys = {}

-- Set up buffer-local keybindings for buffers with LSP enabled
function keys.setup_lsp(bufnr)
  local opts = { buffer = bufnr }
  local map = vim.keymap.set
  local telescope = require('telescope.builtin')

  -- Telescope stuff
  map('n', '<Space>ld', telescope.lsp_definitions, opts)
  map('n', '<Space>lD', telescope.lsp_type_definitions, opts)
  map('n', '<Space>le', telescope.diagnostics, opts)
  map('n', '<Space>li', telescope.lsp_implementations, opts)
  map('n', '<Space>lr', telescope.lsp_references, opts)
  map('n', '<Space>ls', telescope.lsp_workspace_symbols, opts)

  -- Regular LSP stuff
  map('n', 'K',         vim.lsp.buf.hover, opts)
  map('n', '<Space>la', vim.lsp.buf.code_action, opts)
  map('n', '<Space>lR', vim.lsp.buf.rename, opts)
  map('n', '<Space>lf', vim.lsp.buf.formatting, opts)
end

-- Set up default global keybindings
function keys.setup_default()
  local map = vim.keymap.set
  local telescope = require('telescope.builtin')

  -- Telescope
  map('n', '<Space>ff', telescope.find_files)
  map('n', '<Space>fg', telescope.live_grep)
  map('n', '<Space>fb', telescope.buffers)
  map('n', '<Space>fh', telescope.help_tags)
  map('n', '<Space>fm', telescope.man_pages)
  map('n', '<Space>ts', ':Telescope symbols<cr>')

  -- Toggle line numbers
  map('n', '<Space>nn', ':set number!<cr>')
  map('n', '<Space>nr', ':set relativenumber!<cr>')

  -- Switch buffers
  map('n', '<Space><Space>', ':b#<cr>')
  map('n', '<Space>[', ':bp<cr>')
  map('n', '<Space>]', ':bn<cr>')
end

return keys
