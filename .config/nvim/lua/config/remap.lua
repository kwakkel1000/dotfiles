vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Open explorer' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'move selected down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'move selected up' })

vim.keymap.set("n", "J", "mzJ`z", { desc = 'something paste but keep clipboard i think' })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'paste but keep clipboard' })

-- next greatest remap ever : asbjornHaland
-- Yank to system/vim clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'yank to neovim clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'yank to system clipboard' })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'replace current word' })
vim.keymap.set("v", "<leader>s", [[:s/\%V//gI<Left><Left><Left><Left>]],
    { desc = 'replace all in selection' })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = 'make file executable', silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/plugins.lua<CR>");

vim.keymap.set("n", "<leader>SO", function()
    vim.cmd("so")
end)


vim.keymap.set("x", "<leader>rn", [[:<C-u>'<,'>s/\\n/\r/g<CR>]],
    { desc = 'replace \\r\\n to new line ⏎', noremap = true, silent = true })
