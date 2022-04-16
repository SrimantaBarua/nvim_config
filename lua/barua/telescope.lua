local t = {}

-- Configure telescope
function t.configure()
  local telescope = require("telescope")

  telescope.setup {
    pickers = {
      lsp_code_actions = { theme = "cursor" },
      lsp_definitions = { theme = "cursor" },
      lsp_type_definitions = { theme = "cursor" },
      lsp_implementations = { theme = "cursor" },
      lsp_references = { theme = "cursor" },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case"
      }
    }
  }

  -- Load extensions
  telescope.load_extension('fzf')
end

return t
