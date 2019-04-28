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
"" 全角スペースの表示
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme * call ZenkakuSpace()
		autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
	augroup END
	call ZenkakuSpace()
endif
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
nmap <Esc><Esc><Esc> :nohlsearch<CR><Esc>

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
	" コメントカラー変更
	if &term == "xterm-256color"
		colorscheme molokai
		hi Comment ctermfg=102
		hi Visual  ctermbg=236
	endif
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
"" vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
set statusline=%{anzu#search_status()}
"" vim-over
""" 全体置換
nnoremap <silent> <C-h> :OverCommandLine<CR>%s//g<Left><Left>
""" 選択範囲置換
vnoremap <silent> <C-h> :OverCommandLine<CR>s//g<Left><Left>
""" カーソル以下の単語置換
nnoremap <silent> <C-h><C-h> :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
""" ステータスライン強化
set laststatus=2
set showtabline=2
let g:airline_theme = 'molokai'
