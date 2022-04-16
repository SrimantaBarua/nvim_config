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

  map('n', '<Space>la', ':lua require("telescope.builtin").lsp_code_actions()<cr>')
  map('n', '<Space>ld', ':lua require("telescope.builtin").lsp_definitions()<cr>')
  map('n', '<Space>lD', ':lua require("telescope.builtin").lsp_type_definitions()<cr>')
  map('n', '<Space>lg', ':lua require("telescope.builtin").diagnostics()<cr>')
  map('n', '<Space>li', ':lua require("telescope.builtin").lsp_implementations()<cr>')
  map('n', '<Space>lr', ':lua require("telescope.builtin").lsp_references()<cr>')
  map('n', '<Space>ls', ':lua require("telescope.builtin").lsp_workspace_symbols()<cr>')
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

  map('n', '<Space>ff', ':lua require("telescope.builtin").find_files()<cr>')
  map('n', '<Space>fg', ':lua require("telescope.builtin").live_grep()<cr>')
  map('n', '<Space>fb', ':lua require("telescope.builtin").buffers()<cr>')
  map('n', '<Space>fh', ':lua require("telescope.builtin").help_tags()<cr>')
  map('n', '<Space>fm', ':lua require("telescope.builtin").man_pages()<cr>')
end

return keys
