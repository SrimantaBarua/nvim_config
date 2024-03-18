return {
    -- Snippets
    {
        "dcampos/nvim-snippy",   -- Snippy for snippets
        config = function ()
            require("snippy").setup({
                mappings = {
                    is = {
                        ["<C-f>"] = "expand_or_advance",
                        ["<C-b>"] = "previous",
                    }
                },
            })
        end
    },

    -- Mason to manage installations of LSP servers
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Configurations for the built-in neovim lsp client
    "neovim/nvim-lspconfig",

    -- Completion with nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        version = false,  -- The last release is too old
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",  -- Completion from LSP
            "hrsh7th/cmp-buffer",    -- Completion from buffer
            "hrsh7th/cmp-path",      -- Path completions
            "dcampos/nvim-snippy",   -- Snippy for snippets
            "dcampos/cmp-snippy",    -- Snippy as an nvim-cmp source
        },
        config = function ()
            require("barua.lsp").setup_nvim_cmp()
        end
    },

    -- LSP rename with incremental feedback
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup {
                input_buffer_type = "dressing"
            }
        end,
    },

    -- Diagnostics
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    }
}
