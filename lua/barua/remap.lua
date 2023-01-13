vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Cycle between two latest buffers
vim.keymap.set("n", "<leader><leader>", ":b#<CR>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Move highlighted text up and down
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- Keep cursor in place while doing stuff
vim.keymap.set("n", "J", "mzJ`z")        -- Joining lines
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- Scrolling up/down by half page
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")        -- Search terms stay in the middle
vim.keymap.set("n", "N", "Nzzzv")

-- Don't move stuff we paste over into paste register
-- So, when I select 'foo' then copy it, then select 'bar' and paste, it replaces 'bar' with 'foo'
-- but puts 'bar' in the paste register. Keep 'foo' in the paste register.
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Same idea, delete but put it in the void register so it doesn't overwrite the paste register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Start replacing the word I'm currently on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- chmod +x the file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
