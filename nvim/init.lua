-- 基本設定 -----------------------------------------------------------
vim.opt.number = true              -- 行番号を表示
vim.opt.relativenumber = true      -- 相対行番号を表示
vim.opt.tabstop = 4                -- タブ幅を4に設定
vim.opt.shiftwidth = 4             -- 自動インデント時のスペース幅
vim.opt.expandtab = true           -- タブ入力をスペースに変換
vim.opt.smartindent = true         -- スマートインデントを有効化
vim.opt.termguicolors = true       -- 端末のカラーを有効化
vim.opt.clipboard = "unnamedplus"  -- システムクリップボードと連携
vim.opt.wrap = false               -- 折り返しを無効化
vim.opt.showcmd = true             -- コマンドラインに入力中のコマンドを表示
vim.opt.showmatch = true           -- 対応する括弧を強調表示
vim.opt.autoread = true            -- ファイルが変更されたら自動で読み込む

-- バックアップとスワップファイルの設定 --------------------------------
vim.opt.backup = false            -- バックアップファイルを作成しない
vim.opt.swapfile = false           -- スワップファイルを作成しない

-- 検索設定 -----------------------------------------------------------
vim.opt.ignorecase = true          -- 検索時に大文字小文字を区別しない
vim.opt.smartcase = true           -- 大文字が含まれる場合は区別する
vim.opt.incsearch = true           -- 検索文字列を入力中に表示
vim.opt.hlsearch = true            -- 検索結果をハイライト表示

-- シンタックスハイライトの有効化 ------------------------------------
vim.opt.syntax = "enable"          -- シンタックスハイライトを有効化

-- 永続的なアンドゥの設定 --------------------------------------------
if vim.fn.has("persistent_undo") == 1 then
  local undo_dir = vim.fn.expand("~/.vim/undo")
  if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")    -- Undoディレクトリが無ければ作成
  end
  vim.opt.undodir = undo_dir       -- 永続的なアンドゥのディレクトリ指定
  vim.opt.undofile = true          -- アンドゥファイルの有効化
end

-- leaderキーの設定 ---------------------------------------------------
vim.g.mapleader = " "             -- leaderキーをスペースに設定
vim.g.maplocalleader = "\\"        -- local leaderキーをバックスラッシュに設定

-- キーマッピング -----------------------------------------------------
-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- windows
vim.keymap.set("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})  -- Neo-treeを開閉

vim.keymap.set("n", "<leader>l", ":Lazy<CR>", {}) -- lazy.nvimの設定を開く

-- fzf-luaのキーマッピング
-- ルートディレクトリからファイル検索
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files({ cwd = '~' })<CR>", { desc = "find files (root)" })  
vim.keymap.set("n", "<leader>fF", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "find files (cwd)" })  -- ファイル検索
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep({ cwd = '~' })<CR>", { desc = "live grep(root)" }) -- ファイル内検索
vim.keymap.set("n", "<leader>fG", "<cmd>lua require('fzf-lua').live_grep()<CR>", { desc = "live grep(cwd)" }) -- ファイル内検索
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { desc = "find buffers" })  -- バッファ検索
vim.keymap.set("n", "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { desc = "find oldfiles" })  -- 開いたファイル検索


-- lazy.nvimのセットアップ --------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)         -- lazy.nvimをランタイムパスに追加

-- プラグインの設定 ---------------------------------------------------
require("lazy").setup({
  -- Neo-tree: ファイルエクスプローラー
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 25,  -- Neo-treeのウィンドウ幅を設定
          mappings = {
              ["l"] = "open", 
              ["h"] = "close_node",
          }, 
        },
      })
    end,
  },
  -- Bufferline: バッファ管理
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({})
    end,
  },
  -- Gitsigns: Gitの変更を表示
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  -- Which-key: キーマッピングのヘルプ表示
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },
  -- fzf-lua: 高速ファジー検索
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- fzf-luaの依存関係
    },
    config = function()
      -- fzf-lua の設定
      require("fzf-lua").setup({
        -- 基本設定
        winopts = {
          height = 0.85,        -- ウィンドウの高さ
          width = 0.90,         -- ウィンドウの幅
        },
      })
    end,
  },
  -- Copilot: AI補完
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,  -- 自動補完を有効化
          keymap = {
            accept = "<Tab>",    -- Tabキーで補完を受け入れ
            dismiss = "<C-e>",   -- C-eで補完をキャンセル
          },
        },
      })
    end,
  },
  -- Treesitter: シンタックスハイライト
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "markdown", "lua", "cpp", "c", "javascript", "html", "css" },  -- 設定する言語
        highlight = { enable = true },  -- シンタックスハイライトを有効化
      })
    end,
  },
  -- Kanagawa: カラースキーム
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        transparent = false,  -- 背景を透明化しない
        colors = {
          theme = { wave = {}, lotus = {}, dragon = {} },  -- 必要に応じてカスタマイズ
        },
      })
      vim.cmd("colorscheme kanagawa")  -- カラースキームを適用
    end,
  },
  -- Lualine: ステータスライン
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",  
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename", "lsp_progress" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
})
