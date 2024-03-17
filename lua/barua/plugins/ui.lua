return {
    -- LSP progress eye-candy
    {
        "j-hui/fidget.nvim",
        version = "v1.4.0",
        config = function ()
            require("fidget").setup {}
        end
    },

    -- Lightbulb to show available LSP code actions
    {
        'kosayoda/nvim-lightbulb',
        config = function ()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true }
            })
        end
    }
}
