-- Keymaps
local map = vim.keymap.set

-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Document keymaps for which-key (will be loaded after which-key plugin)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>", group = "Leader" },
      { "<C-h>", desc = "Move to left window" },
      { "<C-j>", desc = "Move to lower window" },
      { "<C-k>", desc = "Move to upper window" },
      { "<C-l>", desc = "Move to right window" },
    })
  end,
})
