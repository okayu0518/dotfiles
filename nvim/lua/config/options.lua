-- Options - Keep It Simple
local opt = vim.opt

-- Leader keys (set early)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- UI
opt.number = true           -- Line numbers
opt.relativenumber = true   -- Relative line numbers
opt.signcolumn = "yes"      -- Always show sign column
opt.cursorline = true       -- Highlight current line
opt.showmode = false        -- Don't show mode (statusline shows it)
opt.list = true             -- Show whitespace
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Behavior
opt.mouse = "a"             -- Enable mouse
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true         -- Persistent undo
opt.ignorecase = true       -- Case insensitive search
opt.smartcase = true        -- Case sensitive when uppercase present
opt.inccommand = "split"    -- Live preview for substitution

-- Splits
opt.splitright = true       -- Vertical splits to the right
opt.splitbelow = true       -- Horizontal splits below

-- Indentation
opt.tabstop = 2            -- Tab width
opt.shiftwidth = 2         -- Indent width
opt.expandtab = true       -- Use spaces instead of tabs
opt.autoindent = true      -- Auto indent new lines
opt.breakindent = true     -- Wrapped lines maintain indent

-- Performance
opt.updatetime = 250       -- Faster completion
opt.timeoutlen = 300       -- Faster key sequence completion
opt.scrolloff = 10         -- Keep cursor away from edges
