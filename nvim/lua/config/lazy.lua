-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before any plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim with minimal plugins
require("lazy").setup({
  spec = {
    -- Which-key for keybinding hints
    {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("which-key").setup()
        
        -- Document existing key chains
        require("which-key").add({
          { "<leader>f", group = "[F]ind" },
          { "<leader>ff", desc = "[F]ind [F]iles" },
          { "<leader>fg", desc = "[F]ind by [G]rep" },
          { "<leader>fb", desc = "[F]ind [B]uffers" },
          { "<leader>fh", desc = "[F]ind [H]elp" },
        })
      end,
    },
    -- Fuzzy finder (Telescope)
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup()
        -- Keymaps
        vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Help tags" })
      end,
    },
    -- GitHub Copilot
    {
      "github/copilot.vim",
      config = function()
        vim.g.copilot_no_tab_map = true
        vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      end,
    },
  },
  defaults = {
    lazy = false,
  },
})
