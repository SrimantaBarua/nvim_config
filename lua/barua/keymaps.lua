--[[
    Default keybindings
]]

vim.keymap.set("n", "<leader><leader>", "<cmd>b#<cr>", { desc = "Toggle buffers" })

--[[
    LSP keybindings
]]
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })
