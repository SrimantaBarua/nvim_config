local keys = {}

-- Set up buffer-local keybindings for buffers with LSP enabled
function keys.setup_lsp(bufnr)
  -- Utility function to map keys locally for the buffer
  local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
  end

  -- Telescope stuff
  map('n', '<Space>la', ':lua require("telescope.builtin").lsp_code_actions()<cr>')
  map('n', '<Space>ld', ':lua require("telescope.builtin").lsp_definitions()<cr>')
  map('n', '<Space>lD', ':lua require("telescope.builtin").lsp_type_definitions()<cr>')
  map('n', '<Space>le', ':lua require("telescope.builtin").diagnostics()<cr>')
  map('n', '<Space>li', ':lua require("telescope.builtin").lsp_implementations()<cr>')
  map('n', '<Space>lr', ':lua require("telescope.builtin").lsp_references()<cr>')
  map('n', '<Space>ls', ':lua require("telescope.builtin").lsp_workspace_symbols()<cr>')

  -- Regular LSP stuff
  map('n', 'K', ':lua vim.lsp.buf.hover()<cr>')
  map('n', '<Space>lR', ':lua vim.lsp.buf.rename()<cr>')
  map('n', '<Space>lf', ':lua vim.lsp.buf.formatting()<cr>')
end

-- Set up default global keybindings
function keys.setup_default()
  -- Utility function to map keys globally
  local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  -- Telescope
  map('n', '<Space>ff', ':lua require("telescope.builtin").find_files()<cr>')
  map('n', '<Space>fg', ':lua require("telescope.builtin").live_grep()<cr>')
  map('n', '<Space>fb', ':lua require("telescope.builtin").buffers()<cr>')
  map('n', '<Space>fh', ':lua require("telescope.builtin").help_tags()<cr>')
  map('n', '<Space>fm', ':lua require("telescope.builtin").man_pages()<cr>')
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
