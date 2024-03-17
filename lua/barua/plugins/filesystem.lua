return {
    -- Oil allows editing your filesystem as a neovim buffer.
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup {}
            -- Keymap
            vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
        end
    },

    -- Nvim-tree is a tree-based file browser
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {}
            -- Keymap
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeOpen<cr>", { desc = "Open NvimTree pane" })
        end
    }
}
