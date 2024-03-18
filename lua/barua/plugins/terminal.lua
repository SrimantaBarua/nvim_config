return {
    -- Toggle multiple terminals during an editing session
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            open_mapping = "<C-\\>t"
        }
    },

    -- When opening a file from a terminal buffer, open it in the current Neovim instance.
    {
        "willothy/flatten.nvim",
        opts = {
            window = { open = "alternate" }  -- Open in the previous window, not in the terminal's
        },
        -- Ensure that it runs first to minimize delay when opening file from terminal
        lazy = false,
        priority = 1001,
    },
}
