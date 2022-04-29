local ts = {}

-- Configure tree-sitter
function ts.configure()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "bash", "c", "cmake", "cpp", "glsl", "java", "json", "lua", "make",
                         "python", "query", "regex", "rust", "toml", "typescript", "vim", "yaml" },

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
    },

    -- Enable tree-sitter playground
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?'
      }
    }
  }
end

return ts
