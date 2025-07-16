-- Keymaps - Keep It Simple
local map = vim.keymap.set

-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Visual mode indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines with Alt+j/k
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
