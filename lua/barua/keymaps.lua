--[[
    Default keybindings
]]

vim.keymap.set("n", "<leader><leader>", "<cmd>b#<cr>", { desc = "Toggle buffers" })

--[[
    Filesystem stuff
]]
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory in Oil" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeOpen<cr>", { desc = "Open NvimTree pane" })

--[[
    Fuzzy search with Telescope
]]
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Search help tags" })

--[[
    LSP keybindings
]]
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Run code action" })
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, { desc = "Jump to type definition" })
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Jump to symbol definition" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "<leader>lr", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename symbol" })
