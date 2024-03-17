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
        "kosayoda/nvim-lightbulb",
        config = function ()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true }
            })
        end
    },

    -- Notification popups
    {
        "rcarriga/nvim-notify",
        config = function ()
            vim.notify = require("notify")
            require("notify").setup {
                render = "compact",
                stages = "slide",
            }
        end
    },

    -- Override vim.ui hooks
    {
        'stevearc/dressing.nvim',
        opts = {},
    }
}
