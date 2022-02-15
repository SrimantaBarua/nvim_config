local M = {}

local function get_root_dir(fname)
  local util = require('lspconfig').util
  return util.root_pattern('.git', '.hg')(fname) or vim.loop.cwd()
end

M.configure = function()
  local lspconfig = require('lspconfig')

  -- Callback on LSP attach
  local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require('config.keymap').lsp_keymap(client, bufnr)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local function setup_servers()
    local lspinstall = require('lspinstall')
    lspinstall.setup()
    local servers = lspinstall.installed_servers()
    for _, lang in pairs(servers) do
      if lang ~= 'lua' then
        lspconfig[lang].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = get_root_dir,
        }
      elseif lang == 'lua' then
        lspconfig[lang].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = get_root_dir,
          setings = {
            Lua = {
              diagnostics = {
                globals = {'vim'}
              },
              workspace = {
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
              telemetry = {
                enable = false
              }
            }
          }
        }
      end
    end
  end

  setup_servers()

  -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
  require('lspinstall').post_install_hook = function()
    setup_servers()
    vim.cmd('bufdo e')
  end
end

return M
