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
set listchars=tab:>-,trail:~,extends:>,precedes:<
set showcmd               " コマンド入力中の内容を表示
set laststatus=2          " ステータスラインを常に表示
set showmatch             " 対応する括弧を強調表示

" カラースキームとシンタックス
" colorscheme evening        " カラースキーム（お好みで変更可能）
syntax on                 " シンタックスハイライトを有効化

" タブとインデント設定
set tabstop=4             " タブを4スペースとして表示
set shiftwidth=4          " 自動インデントを4スペースに設定
set expandtab             " タブ文字ではなくスペースを使用
set autoindent            " 自動インデントを有効化
set smartindent           " スマートインデントを有効化

" 検索設定
set ignorecase            " 検索時に大文字小文字を無視
set smartcase             " 大文字を含む場合は大文字小文字を区別
set incsearch             " インクリメンタルサーチを有効化
set hlsearch              " 検索結果をハイライト
nnoremap <ESC><ESC> :nohlsearch<CR> " ESC 2回でハイライト解除

" 永続的なアンドゥ設定
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  if !isdirectory(undo_path)
    call mkdir(undo_path, 'p')
  endif
  set undodir=~/.vim/undo
  set undofile
endif

" その他の設定
set mouse=a               " マウスを有効化
set clipboard=unnamedplus " システムクリップボードを使用
set wildmenu              " コマンド補完メニューを有効化
set formatoptions+=mM     " 日本語で折り返しを有効化

" netrw（ファイルブラウザ）設定
let g:netrw_liststyle = 3
