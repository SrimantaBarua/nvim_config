return {
    -- Native Telescope sorter using fzf
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = false,
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },

    -- Telescope for fuzzy search
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function ()
            require("telescope").setup {
                extensions = {
                    fzf = {}
                }
            }
            require("telescope").load_extension("fzf")

            -- Set key bindings
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })
        end
    },
}
