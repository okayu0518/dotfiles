-- ~/.config/nvim/init.lua
-- Simple Neovim Configuration

--==============================================================================
-- CORE SETUP
--==============================================================================

-- Leader key
vim.g.mapleader = " "

--==============================================================================
-- PLUGIN MANAGER SETUP
--==============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--==============================================================================
-- PLUGINS
--==============================================================================

require("lazy").setup({
  -- FZF Fuzzy Finder
  {
    "junegunn/fzf",
    build = function() vim.fn["fzf#install"]() end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<C-p>", ":Files<CR>", desc = "Find files" },
      { "<leader>fg", ":Rg<CR>", desc = "Live grep" },
      { "<leader>fb", ":Buffers<CR>", desc = "Find buffers" },
    },
  },

  -- File Tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
    end,
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file tree" },
    },
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },

  -- Tree-sitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Which Key - Key mapping guide
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        delay = 500,
        win = {
          border = "rounded",
          padding = { 2, 2, 2, 2 },
        },
      })
      
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fb", desc = "Find buffers" },
        { "<leader>e", desc = "Toggle file tree" },
        { "<leader>w", desc = "Save file" },
        { "<leader>q", desc = "Quit" },
      })
    end,
  },
})

--==============================================================================
-- VIM OPTIONS
--==============================================================================

local opt = vim.opt

-- UI & Appearance
opt.number = true                -- Show line numbers
opt.relativenumber = true        -- Show relative line numbers
opt.cursorline = true            -- Highlight current line
opt.termguicolors = true         -- Enable true colors
opt.signcolumn = "yes"           -- Always show sign column
opt.wrap = false                 -- Don't wrap lines
opt.scrolloff = 8                -- Keep 8 lines above/below cursor
opt.colorcolumn = "80"           -- Show column at 80 characters

-- Editing & Indentation
opt.expandtab = true             -- Use spaces instead of tabs
opt.shiftwidth = 2               -- Number of spaces for indentation
opt.tabstop = 2                  -- Number of spaces tab counts for
opt.smartindent = true           -- Smart auto-indenting

-- Search behavior
opt.ignorecase = true            -- Ignore case in search patterns
opt.smartcase = true             -- Override ignorecase if search contains uppercase
opt.hlsearch = true              -- Highlight search results
opt.incsearch = true             -- Show search matches as you type

-- File handling
opt.backup = false               -- Don't create backup files
opt.swapfile = false             -- Don't create swap files
opt.undofile = true              -- Enable persistent undo

-- Performance
opt.updatetime = 250             -- Faster completion
opt.clipboard = "unnamedplus"    -- Use system clipboard

--==============================================================================
-- KEY MAPPINGS
--==============================================================================

local keymap = vim.keymap.set

-- Basic mappings
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Window navigation
keymap("n", "<C-h>", "<C-w><C-h>")
keymap("n", "<C-l>", "<C-w><C-l>")
keymap("n", "<C-j>", "<C-w><C-j>")
keymap("n", "<C-k>", "<C-w><C-k>")

-- Buffer navigation
keymap("n", "<Tab>", "<cmd>bnext<CR>")
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>")

-- Copilot mappings
keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

