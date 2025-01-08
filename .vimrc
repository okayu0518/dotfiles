" バックアップファイルやスワップファイルを作成しない
set nobackup
set nowritebackup
set noswapfile

" 行番号を表示
set number
set relativenumber

" タブとインデントの設定
set tabstop=4        " タブを4スペースとして表示
set shiftwidth=4     " 自動インデントを4スペースに設定
set expandtab        " タブ文字ではなくスペースを使用
set autoindent       " 自動インデントを有効化
set smartindent      " スマートインデントを有効化

" 検索の設定
set ignorecase       " 検索時に大文字小文字を無視
set smartcase        " 大文字を含む場合は大文字小文字を区別
set incsearch        " インクリメンタルサーチを有効化
set hlsearch         " 検索結果をハイライト
nnoremap <ESC><ESC> :nohlsearch<CR> " ESC 2回でハイライト解除

" ファイルエンコーディングの設定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

" スクロール時に上下に余裕を持たせる
set scrolloff=5

" マウスを有効化
set mouse=a


" カラースキーム
colorscheme desert " お好みで変更可能

" シンタックスハイライトを有効化
syntax on

" ステータスラインを常に表示
set laststatus=2

" 見やすい記号を表示（例: 不可視文字）
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" コマンド入力中の内容を表示
set showcmd

" 開いているときに他から変更されたら自動で読み込む
set autoread

" 保存されていないファイルがあるときでも別のファイルを開ける
set hidden


" 永続的なアンドゥを有効化
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  if !isdirectory(undo_path)
    call mkdir(undo_path, 'p')
  endif
  exe 'set undodir=' .. undo_path
  set undofile
endif

" システムクリップボードを使用
set clipboard=unnamedplus

" コマンド補完メニューを有効化
set wildmenu

" 括弧の対応を強調表示
set showmatch

" 日本語で折り返し
" フォーマットオプションの設定
set formatoptions+=mM

" タイトルを有効化
set title

let g:netrw_liststyle = 3
