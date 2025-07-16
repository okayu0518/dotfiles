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

-- Window management
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffer management
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

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

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Quick save and quit
map("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all without saving" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Paste without losing register in visual mode
map("x", "<leader>p", [["_dP]], { desc = "Paste without losing register" })

-- Copy to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- Delete to black hole register
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole register" })

-- Quickfix
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Terminal
map("n", "<leader>ft", function()
  vim.cmd("split")
  vim.cmd("terminal")
  vim.cmd("resize 15")
end, { desc = "Open terminal" })

-- Search and replace
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- Toggle options
map("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Wrap " .. (vim.wo.wrap and "enabled" or "disabled"))
end, { desc = "Toggle wrap" })

map("n", "<leader>un", function()
  vim.wo.number = not vim.wo.number
  print("Line numbers " .. (vim.wo.number and "enabled" or "disabled"))
end, { desc = "Toggle line numbers" })

map("n", "<leader>ur", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  print("Relative numbers " .. (vim.wo.relativenumber and "enabled" or "disabled"))
end, { desc = "Toggle relative numbers" })
