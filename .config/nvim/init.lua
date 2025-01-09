-- バックアップファイルやスワップファイルを作成しない
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- 行番号を表示
vim.opt.number = true
vim.opt.relativenumber = true

-- タブとインデントの設定
vim.opt.tabstop = 4        -- タブを4スペースとして表示
vim.opt.shiftwidth = 4     -- 自動インデントを4スペースに設定
vim.opt.expandtab = true   -- タブ文字ではなくスペースを使用
vim.opt.autoindent = true  -- 自動インデントを有効化
vim.opt.smartindent = true -- スマートインデントを有効化

-- 検索の設定
vim.opt.ignorecase = true  -- 検索時に大文字小文字を無視
vim.opt.smartcase = true   -- 大文字を含む場合は大文字小文字を区別
vim.opt.incsearch = true   -- インクリメンタルサーチを有効化
vim.opt.hlsearch = true    -- 検索結果をハイライト
vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR>", { noremap = true, silent = true }) -- ESC 2回でハイライト解除

-- ファイルエンコーディングの設定
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "iso-2022-jp", "euc-jp", "sjis" }

-- スクロール時に上下に余裕を持たせる
vim.opt.scrolloff = 5

-- マウスを有効化
vim.opt.mouse = "a"

-- カラースキーム
-- vim.cmd("colorscheme desert") -- お好みで変更可能

-- シンタックスハイライトを有効化
vim.cmd("syntax on")

-- ステータスラインを常に表示
vim.opt.laststatus = 2

-- 見やすい記号を表示（例: 不可視文字）
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "~", extends = ">", precedes = "<" }

-- コマンド入力中の内容を表示
vim.opt.showcmd = true

-- 開いているときに他から変更されたら自動で読み込む
vim.opt.autoread = true

-- 保存されていないファイルがあるときでも別のファイルを開ける
vim.opt.hidden = true

-- 永続的なアンドゥを有効化
if vim.fn.has("persistent_undo") == 1 then
  local undo_path = vim.fn.expand("~/.vim/undo")
  if vim.fn.isdirectory(undo_path) == 0 then
    vim.fn.mkdir(undo_path, "p")
  end
  vim.opt.undodir = undo_path
  vim.opt.undofile = true
end

-- システムクリップボードを使用
vim.opt.clipboard = "unnamedplus"

-- コマンド補完メニューを有効化
vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest" }

-- 括弧の対応を強調表示
vim.opt.showmatch = true

-- 日本語で折り返し
vim.opt.formatoptions:append("mM")

-- タイトルを有効化
vim.opt.title = true

-- netrw のリストスタイルを設定
vim.g.netrw_liststyle = 3

-- Shift + 矢印でウィンドウサイズを変更
vim.keymap.set("n", "<C-Left>", "<C-w><<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", "<C-w>><CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Up>", "<C-w>-<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", "<C-w>+<CR>", { noremap = true, silent = true })

-- カーソルラインの位置を保存する
if vim.fn.has("autocmd") == 1 then
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
      local last_pos = vim.fn.line("'\"")
      if last_pos > 0 and last_pos <= vim.fn.line("$") then
        vim.cmd("normal! g'\"")
      end
    end
  })
end
