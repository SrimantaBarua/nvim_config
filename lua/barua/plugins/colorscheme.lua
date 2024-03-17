return {
    -- Catppuccin color scheme
    {
        "catppuccin/nvim",
        priority = 1000,  -- Make sure to load this before all other plugins
        config = function ()
            vim.cmd.colorscheme "catppuccin-mocha"
        end
    }
}

