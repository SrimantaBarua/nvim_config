return {
    -- Mason to manage installations of LSP servers
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Configurations for the built-in neovim lsp client
    "neovim/nvim-lspconfig",

    -- LSP progress eye-candy
    {
        "j-hui/fidget.nvim",
        version = "v1.4.0",
        config = function ()
            require("fidget").setup {}
        end
    }
}
