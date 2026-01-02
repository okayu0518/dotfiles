" don't try to be vi compatible
set nocompatible
" 基本設定
set nobackup              " バックアップファイルを作成しない
set nowritebackup         " 書き込み時のバックアップを作成しない
set noswapfile            " スワップファイルを作成しない
set encoding=utf-8        " ファイルエンコーディングをUTF-8に設定
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set hidden                " 未保存のファイルがあっても他のファイルを開ける
set autoread              " 他で変更されたファイルを自動で読み込む
set title                 " ウィンドウタイトルを有効化

" 表示設定
set number                " 行番号を表示
set relativenumber        " 相対行番号を表示
set scrolloff=5           " スクロール時の余白
set list                  " 不可視文字を表示
set listchars=tab:^\ ,trail:~
set showcmd               " コマンド入力中の内容を表示
set laststatus=2          " ステータスラインを常に表示
set showmatch             " 対応する括弧を強調表示
set cursorline            " highlight the current line
set ruler                 " カーソル位置を表示
set wrap                " 行を折り返す

" カラースキームとシンタックス
" colorscheme evening        " カラースキーム（お好みで変更可能）
syntax on                 " シンタックスハイライトを有効化

" タブとインデント設定
set tabstop=4             " タブを4スペースとして表示
set shiftwidth=4          " 自動インデントを4スペースに設定
"set expandtab             " タブ文字ではなくスペースを使用
set autoindent            " 自動インデントを有効化
set smartindent           " スマートインデントを有効化

" 検索設定
set ignorecase            " 検索時に大文字小文字を無視
set smartcase             " 大文字を含む場合は大文字小文字を区別
set incsearch             " インクリメンタルサーチを有効化
set hlsearch              " 検索結果をハイライト
"nnoremap <ESC><ESC> :nohlsearch<CR> " ESC 2回でハイライト解除

" 永続的なアンドゥ設定
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  if !isdirectory(undo_path)
    call mkdir(undo_path, 'p')
  endif
  set undodir=~/.vim/undo
  set undofile
endif

" カーソル位置記憶
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

" その他の設定
set mouse=a               " マウスを有効化
set clipboard=unnamedplus " システムクリップボードを使用
set wildmenu              " コマンド補完メニューを有効化
set formatoptions+=mM     " 日本語で折り返しを有効化

" netrw（ファイルブラウザ）設定
let g:netrw_liststyle = 1
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1

"" バッファ機能強化設定
"" 次のバッファに移動
"nnoremap ]b :bnext<CR>
"
"" 前のバッファに移動
"nnoremap [b :bprevious<CR>
"
"" ウィンドウ分割のサイズ変更
"nnoremap <C-Left> :vertical resize -2<CR>
"nnoremap <C-Right> :vertical resize +2<CR>
"nnoremap <C-Up> :resize +2<CR>
"nnoremap <C-Down> :resize -2<CR>

" カーソル形状変更
let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[1 q"

" use insert mode like emacs
"inoremap <C-d> <Del>
"inoremap <C-h> <BS>
"inoremap <C-a> <home>
"inoremap <C-e> <End>
"inoremap <C-p> <Up>
"inoremap <C-n> <Down>
"inoremap <C-f> <right>
"inoremap <C-b> <left>

" 表示行単位で上下移動するように
"nnoremap j gj
"nnoremap k gk

" Windows CRLFを削除
autocmd BufReadPost * silent! %s/\r//g
