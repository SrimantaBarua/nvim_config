return {
    -- Magit-like experience inside neovim
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {}
    },

    -- Git signs, plus blame
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true
        }
    }
}
