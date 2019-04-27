# 環境変数
## 日本語設定
export LANG=ja_JP.UTF-8

# 色設定
## 色を使用
autoload -Uz colors
colors
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


# キー設定
## Ctrl+sのロック, Ctrl+qのロック解除を無効にする
stty stop undef
stty start undef
bindkey "^[[3~" delete-char
## Ctrl+カーソルキー移動の有効化
bindkey ";5C" forward-word
bindkey ";5D" backward-word
## Ctrl-Dでログアウトしない
setopt ignoreeof

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
