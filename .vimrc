" setting
"" ファイル読み込み時の文字コード
set encoding=utf-8
"" マルチバイトを扱う際の設定j
scriptencoding utf-8
"" 保存時の文字コード
set fileencoding=utf-8
"" 読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
"" 改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac
"" □や○文字が崩れる問題を解決
set ambiwidth=double
"" スワップファイルを作らない
set nobackup
"" バックアップファイルを作らない
set noswapfile
"" 編集中のファイルが変更されたら自動で読み直す
set autoread
"" バッファが編集中でもその他のファイルを開けるように
set hidden
"" 入力中のコマンドをステータスに表示する
set showcmd

" カーソル系
"" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~
" 挿入モードでも上下左右移動可能
:imap <c-h> <Left>
:imap <c-j> <Down>
:imap <c-k> <Up>
:imap <c-l> <Right>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
"" バックスペースキーの有効化
set backspace=indent,eol,start

" 見た目系
"" シンタックスハイライトの有効化
syntax enable
""" 行番号を表示
set number
"" 空白文字表示
set list
"" Tabを表示形式
set listchars=tab:»-
"" Tab文字色設定
hi SpecialKey ctermbg=None ctermfg=59
"" 行末スペース強調
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END　
"" 括弧入力時に対応するカーソルを強調
set showmatch
"" 括弧入力強調時間
set matchtime=1
"" ステータスラインを常に表示
set laststatus=2
"" コマンドモードの補完
set wildmenu
"" 保存するコマンド履歴の数
set history=5000

" インデント系
"" インデントにTabを使用
set noexpandtab
"" 画面上でタブ文字が占める幅
set tabstop=8
"" Tabに変換するスペースの数
set softtabstop=8
"" 改行時に前の行のインデントを継続する
set autoindent
"" smarttab
set smarttab
"" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
"" smartindentで増減する幅
set shiftwidth=8
"" ファイル別インデント設定
augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END


" 検索系
"" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
"" 検索パターンに大文字小文字を区別しない
set ignorecase
"" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
"" 検索結果をハイライト
set hlsearch
"" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" マウス操作の有効化
if has('mouse')
	set mouse=a
	if has('mouse_sgr')
		set ttymouse=sgr
	elseif v:version > 703 || v:version is 703 && has('patch632') " I couldn't use has('mouse_sgr') :-(
		set ttymouse=sgr
	else
		set ttymouse=xterm2
	endif
endif

" ペースト時のスマートインデント無効化
if &term =~ "xterm"
	let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?2004l"
	let &pastetoggle = "\e[201~"

	function XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction

	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


" GNU GLOBAL(gtags)
"" 検索結果windowを閉じる
nmap <C-q> <C-w><C-w><C-w>q
"" ソースコードのgrep
nmap <C-g> :Gtags -g
"" 開いているファイルの定義元一覧
nmap <C-l> :Gtags -f %<CR>
"" カーソル以下の定義元一覧
nmap <C-j> :Gtags <C-r><C-w><CR>
"" カーソル以下の使用箇所一覧
nmap <C-k> :Gtags -r <C-r><C-w><CR>
"" カーソル以下の単語検索
nmap <C-h> :GtagsCursor<CR>
"" 次の検索結果へジャンプ
nmap <C-n> :cn<CR>
"" 前の検索結果へジャンプ
nmap <C-p> :cp<CR>

