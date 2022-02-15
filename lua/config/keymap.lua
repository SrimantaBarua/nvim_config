local M = {}

M.general_keymap = function()
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true }

  -- Global keybinding
  map('n', '<space>ll', '<cmd>set number!<cr>', opts)         -- Toggle line numbers
  map('n', '<space>lr', '<cmd>set relativenumber!<cr>', opts) -- Toggle relative line numbers
  map('n', '<space><space>', '<cmd>b#<cr>', opts)             -- Toggle buffers
  map('n', '<space>[', '<cmd>bp<cr>', opts)                   -- Switch to previous buffer
  map('n', '<space>]', '<cmd>bn<cr>', opts)                   -- Switch to next buffer

  -- Keybindinds for FZF
  map('n', '<space>fb', '<cmd>Buffers<cr>', opts)   -- Open buffers
  map('n', '<space>fc', '<cmd>Commands<cr>', opts)  -- Vim commands
  map('n', '<space>ff', '<cmd>Files<cr>', opts)     -- Files in directory tree
  map('n', '<space>fh', '<cmd>Helptags<cr>', opts)  -- Fuzzy search for help tags
  map('n', '<space>fr', '<cmd>Rg<cr>', opts)        -- Run ripgrep
end

M.lsp_keymap = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true }

  -- General mappins
  buf_set_keymap('n', '<space>Lgd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', '<space>LgD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', '<space>Lh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', '<space>Li', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', '<space>Ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '<space>Lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<space>Lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<space>Lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  buf_set_keymap('n', '<space>Ltd', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', '<space>LR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<space>Lr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', '<space>Ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
  buf_set_keymap('n', '<space>L[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', '<space>L]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<space>Lld', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)

  -- Set some keybindings conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<space>Lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<space>Lf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)
  end
end

return M
