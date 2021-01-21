# 環境変数
## 日本語設定
export LANG=ja_JP.UTF-8
## XDG configuration
export XDG_CONFIG_HOME=$HOME/.config
## path設定
path=($HOME/local/bin $path)
path=($HOME/.local/bin $path)
path=($HOME/bin $path)
## mac gnu commands path設定
PATH="PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH""
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"

# メタ文字対策
setopt nonomatch

# キー設定
## キーバインドをemacs風に
bindkey -e
## Ctrl+sのロック, Ctrl+qのロック解除を無効にする
stty stop undef
stty start undef
bindkey "^[[3~" delete-char
## Ctrl+カーソルキー移動の有効化
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey "5C" forward-word
bindkey "5D" backward-word
## Ctrl-Dでログアウトしない
setopt ignoreeof

# エイリアス設定
## sudo
alias sudo='sudo '
## cd
alias ...='cd ../..'
alias ....='cd ../../..'
## ls
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -lha'
alias lls='ls -lhS'
alias llt='ls -lht'
## files
alias md='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
## find
alias fn='find -iname'
## grep
alias gr='grep --color -irn'
alias gf='grep --color -irl'
## global alias
alias -g L='| less'
alias -g H='| head -n'
alias -g T='| tail -n'
alias -g G='| grep --color -i'
## git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gu='git restore --staged'
alias gc='git commit'
alias gcm='git commit -m'
alias grs='git reset'
alias grb='git rebase -i'
alias gsv='git stash'
alias gld='git stash pop'
alias gd='git diff'
alias gdc='git diff --cached'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gb='git branch'
alias gbm='git branch --merged'
alias gbn='git branch --no-merged'
alias gmr='git merge'
alias gcp='git cherry-pick -e'
alias gdump='git cat-file -p'
alias gcl='git clone'
alias gps='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gl='git log --graph --decorate --all'
alias glo='git log --graph --decorate --oneline --all'
## commands
alias to='touch'
alias wi='which'
## alias expand
function expand-alias() {
	zle _expand_alias
	zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

# 色設定
## 色を使用
autoload -Uz colors
colors
## 256色を使用
export TERM=xterm-256color
## ls color
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'
# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
	 darwin*)
		 # Mac
		 alias ls="ls -GF"
		 ;;
	 linux*)
		 # Linux
		 alias ls='ls -F --color'
		 ;;
esac

# プロンプト系
## プロンプト表示設定
PROMPT="%{${fg[white]}%}[%n@%m]%{${reset_color}%}%{${fg[yellow]}%} %d%{${reset_color}%}
%# "
## git設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
### stageされているがコミットされていないものがあれば[黄色で!]
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
### addされていないものがあれば[赤色で+]
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
### 通常状態なら[緑色表示]
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
### 上記の表示形式
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# 補完機能系
## 補完有効化
autoload -Uz compinit && compinit
## 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## 補完候補一覧表示
setopt auto_list
## tabで補完候補切り替え
setopt auto_menu
## tab,矢印キーで補完選択
zstyle ':completion:*:default' menu select=1

# 移動系
## ディレクトリ名だけで移動
setopt auto_cd
## cdしたら自動でpushdする
setopt auto_pushd
## pushdから重複を削除
setopt pushd_ignore_dups
## cd -[Tab]で移動履歴検索
setopt auto_pushd

# 区切り文字系
## 単語の区切り文字設定
autoload -Uz select-word-style
select-word-style default
## ここで指定した文字は単語区切りとみなされる
## / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# history系
## 保存先
HISTFILE=$HOME/.zsh-history
## 保存サイズ
HISTSIZE=1000000  # メモリ
SAVEHIST=1000000  # ファイル
## 異なるウィンドウでもhistoryを共有
setopt share_history
## 重複コマンドを記録しない
setopt hist_ignore_all_dups
## コマンド履歴検索
## Ctrl-P（前）/Ctrl-N（後）
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# プログラミング関係
## GTAGS設定
export GTAGSFORCECPP=1
## CTAGS設定
alias ctags-vscode='ctags -R --fields=+nKz --languages=-C,-C++,-C#,-Java,-JavaScript,-PHP,-Ruby,-Python'
## anyenv
if [[ -d $HOME/.anyenv ]]; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"
fi

# その他
## デフォルトシェルの設定
export EDITOR='vim'
export VISUAL='vim'
## ビープ音無効
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
## コマンド訂正
setopt correct
## #をコマンドとみなす
setopt interactive_comments
