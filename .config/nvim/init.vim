" setting
"" ファイル読み込み時の文字コード
set encoding=utf-8
"" マルチバイトを扱う際の設定
scriptencoding utf-8
"" 保存時の文字コード
set modifiable
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
"" インサートモードから抜ける
inoremap <silent> jj <ESC>
"" バックスペースキーの有効化
set backspace=indent,eol,start

" 見た目系
"" シンタックスハイライトの有効化
syntax enable
"" 行番号を表示
set number
"" カーソル強調表示
set cursorline
"" カッコ強調表示オフ
let loaded_matchparen = 1
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

" history系
"" コマンドモードの補完
set wildmenu
"" 保存するコマンド履歴の数
set history=5000

" インデント系
"" インデントにTabを使用
set noexpandtab
"" 画面上でタブ文字が占める幅
set tabstop=4
"" Tabに変換するスペースの数
set softtabstop=4
"" 改行時に前の行のインデントを継続する
set autoindent
"" smarttab
set smarttab
"" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
"" smartindentで増減する幅
set shiftwidth=4
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
nnoremap <silent><Esc><Esc> :nohlsearch<CR><Esc>

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

" vim-plug
"" install vim-plug start
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
	silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . 
		\ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
	execute 'source ' . fnameescape(autoload_plug_path)
	let plug_install = 1
endif
unlet autoload_plug_path

"" install plugins
call plug#begin('~/.config/nvim/plugins')
	" 表示系
	Plug 'tomasr/molokai'  " カラースキーム
	Plug 'Yggdroot/indentLine'  " インデント表示
	Plug 'bronson/vim-trailing-whitespace'  " 末尾の全角と半角の空白文字を可視化
	Plug 'vim-airline/vim-airline'  " ステータスライン強化
	Plug 'vim-airline/vim-airline-themes'  " ステータスラインカラースキーム
	Plug 'psliwka/vim-smoothie'  " スムーズスクロール
	Plug 'machakann/vim-highlightedyank'  " yank時にハイライトする
	" 便利系
	Plug 'easymotion/vim-easymotion'  " easy-motion
	Plug 'tpope/vim-surround'  "" surround
	Plug 'tpope/vim-commentary'  "" コメントコマンド
	Plug 'jiangmiao/auto-pairs'  " カッコ自動補完
	Plug 'osyo-manga/vim-anzu'  " 検索ヒット数表示
	" git系
	Plug 'airblade/vim-gitgutter'  " 変更箇所を表示
call plug#end()

"" install vim-plug end
if plug_install
	PlugInstall --sync
endif
unlet plug_install

" vim-plug plugin setting
"" check the specified plugin is installed
function s:is_plugged(name)
	if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
		return 1
	else
		return 0
	endif
endfunction
"" settings
if s:is_plugged("molokai")
	syntax on
	autocmd ColorScheme * highlight Comment ctermfg=102
	autocmd ColorScheme * highlight Visual  ctermbg=236
	colorscheme molokai
	autocmd GUIEnter * colorscheme molokai
	set t_Co=256
endif
if s:is_plugged("indentLine")
	set list listchars=tab:\¦\ 
	let g:indentLine_char = '¦'
	let g:indentLine_leadingSpaceEnabled = 1
	let g:indentLine_leadingSpaceChar = '･'
endif
if s:is_plugged("vim-airline")
	set laststatus=2
	set showtabline=2
	let g:airline_theme = 'molokai'
endif
if s:is_plugged("vim-highlightedyank")
	let g:highlightedyank_highlight_duration = 150
endif
if s:is_plugged("vim-easymotion")
	let g:EasyMotion_do_mapping = 0
	let g:EasyMotion_smartcase = 1
	nmap s <Plug>(easymotion-s2)
endif
if s:is_plugged("vim-anzu")
	nmap n <Plug>(anzu-n-with-echo)
	nmap N <Plug>(anzu-N-with-echo)
	nmap * <Plug>(anzu-star-with-echo)
	nmap # <Plug>(anzu-sharp-with-echo)
	set statusline=%{anzu#search_status()}
endif
