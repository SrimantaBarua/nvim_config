local ts = {}

-- Configure tree-sitter
function ts.configure()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "bash", "c", "cmake", "cpp", "java", "json", "lua", "make", "python",
                         "query", "regex", "rust", "toml", "typescript", "vim", "yaml" },

    highlight = {
      -- Enable syntax highlighting
      enable = true,
    },

    -- Enable incremental selection based on grammar nodes
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gt",
        node_incremental = "gu",
        scope_incremental = "gs",
        node_decremental = "gd"
      }
    }
  } 
end

return ts
