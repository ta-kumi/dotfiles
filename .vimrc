" setting
"" ファイル読み込み時の文字コード
set encoding=utf-8
"" マルチバイトを扱う際の設定
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
"" モードによってカーソルを変化させる
if has('vim_starting')
	" 挿入モード時に非点滅の縦棒タイプのカーソル
	let &t_SI .= "\e[6 q"
	" ノーマルモード時に非点滅のブロックタイプのカーソル
	let &t_EI .= "\e[2 q"
	" 置換モード時に非点滅の下線タイプのカーソル
	let &t_SR .= "\e[4 q"
endif


" キー設定
""" スペースキーを使用しない
noremap <Space> <Nop>
"" <Leader>キーの割当
let mapleader = "\<Space>"
"" バックスペースキーの有効化
set backspace=indent,eol,start

" 見た目系
"" シンタックスハイライトの有効化
syntax enable
""" 行番号を表示
set number
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
	if !has('nvim')
		if has('mouse_sgr')
			set ttymouse=sgr
		elseif v:version > 703 || v:version is 703 && has('patch632')
			set ttymouse=sgr
		else
			set ttymouse=xterm2
		endif
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

" dein
"" dein基本設定
if &compatible
	set nocompatible " Be iMproved
endif
let s:dein_path = expand('~/.vim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'
"" dein.vim がなければ github からclone
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_path)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif
if dein#load_state(s:dein_path)
	call dein#begin(s:dein_path)
	let g:config_dir = expand('~/.vim/dein/userconfig')
	let s:toml       = g:config_dir . '/plugins.toml'
	let s:lazy_toml  = g:config_dir . '/plugins_lazy.toml'
	" TOML 読み込み
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif
filetype plugin indent on
syntax enable
"" インストールされていないプラグインがあればインストールする
if dein#check_install()
	call dein#install()
endif
set t_Co=256

" プラグイン設定一覧
"" molokai
if dein#tap('molokai')
	colorscheme molokai
	autocmd GUIEnter * colorscheme molokai
endif
"" indentLine
:set list lcs=tab:\|\ 
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_color_term = 237
let g:indentLine_leadingSpaceChar = '･'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"" vim-easy-align
""" enterで整形設定に行くようにする
vmap <Enter> <Plug>(EasyAlign)
"" nerdcommenter
""" コメントにスペースを開ける
let g:NERDSpaceDelims=1
""" コメントを左に並べる
let g:NERDDefaultAlign='left'
"" コード自動補完系
if dein#tap('neocomplete.vim')
	" Vim起動時にneocompleteを有効にする
	let g:neocomplete#enable_at_startup = 1
	" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
	let g:neocomplete#enable_smart_case = 1
	" 3文字以上の単語に対して補完を有効にする
	let g:neocomplete#min_keyword_length = 3
	" 区切り文字まで補完する
	let g:neocomplete#enable_auto_delimiter = 1
	" 1文字目の入力から補完のポップアップを表示
	let g:neocomplete#auto_completion_start_length = 1
	" バックスペースで補完のポップアップを閉じる
	inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
	" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
	imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
	" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
	imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif
