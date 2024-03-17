return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cmake",
                    "comment", -- For highlighting stuff like TODO etc inside comments
                    "cpp",
                    "diff",
                    "dockerfile",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "kotlin",
                    "lua",
                    "make",
                    "nasm",
                    "objc",
                    "python",
                    "rust",
                    "smithy",
                    "sql",
                    "tlaplus",
                    "toml",
                    "typescript",
                    "vim",
                    "vimdoc",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    init_selection = "<leader>ts",
                    node_incremental = "<leader>tn",
                    scope_incremental = "<leader>ts",
                    node_decremental = "<leader>tN",
                },
                indent = {
                    enable = true
                },
                modules = {},
                ignore_install = {},
                auto_install = false,
                sync_install = false,
            })
        end
    }
}
