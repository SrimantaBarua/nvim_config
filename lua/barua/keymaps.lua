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

vim.keymap.set("n", "<leader>fm", telescope_builtin.marks, { desc = "Search marks" })

vim.keymap.set("n", "<leader>fr", telescope_builtin.registers, { desc = "Search registers" })


--[[
    Quickfix list
]]

vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", { desc = "Previous item in quickfix list" })

vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next item in quickfix list" })

vim.keymap.set("n", "<leader>qo", "<cmd>copen<cr>", { desc = "Open the quickfix window" })

vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Close the quickfix window" })


--[[
    Diagnostics (with trouble)
]]

vim.keymap.set("n", "<leader>dd", function ()
    require("trouble").toggle("document_diagnostics")
end, { desc = "Toggle document diagnostics" })

vim.keymap.set("n", "<leader>dw", function ()
    require("trouble").toggle("workspace_diagnostics")
end, { desc = "Toggle workspace diagnostics" })


--[[
    LSP keybindings
]]
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Hover" })

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Run code action" })

vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, { desc = "Jump to type definition" })

vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Jump to symbol definition" })

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>lh", function ()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
end, { desc = "Toggle inlay hints" })

vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Go to implementation" })

vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, { desc = "References" })

vim.keymap.set("n", "<leader>lr", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename symbol" })
