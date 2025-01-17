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
vim.cmd("syntax on")               -- シンタックスハイライトを有効化

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
vim.g.maplocalleader = " "         -- ローカルのleaderキーもスペース

-- キーマッピング -----------------------------------------------------
local set_keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ウィンドウサイズ変更（Ctrl+矢印でウィンドウのリサイズ） --------------
set_keymap("n", "<C-Up>", ":resize -2<CR>", opts)
set_keymap("n", "<C-Down>", ":resize +2<CR>", opts)
set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ウィンドウ間移動（Ctrl+h/j/k/lでウィンドウ間移動） -------------------
set_keymap("n", "<C-h>", "<C-w>h", opts)
set_keymap("n", "<C-j>", "<C-w>j", opts)
set_keymap("n", "<C-k>", "<C-w>k", opts)
set_keymap("n", "<C-l>", "<C-w>l", opts)

-- バッファ間移動（Shift+h/j/k/lでバッファ間移動） ---------------------
set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

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
        },
      })
      set_keymap("n", "<leader>e", ":Neotree toggle<CR>", opts)  -- Neo-treeを開閉
    end,
  },
  -- Bufferline: バッファ管理
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({})
      set_keymap("n", "[b", ":BufferLineCyclePrev<CR>", opts)  -- 前のバッファへ移動
      set_keymap("n", "]b", ":BufferLineCycleNext<CR>", opts)  -- 次のバッファへ移動
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
  -- Telescope: ファイル/テキスト検索
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)  -- ファイル検索
      set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)   -- テキスト検索
      set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)     -- バッファ一覧
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
})
