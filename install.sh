#!/bin/bash

DOTPATH=~/.dotfiles

for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done

# neovim対応
if [[ ! -e ${HOME}/.config/nvim/ ]]; then
	mkdir -p ${HOME}/.config/nvim/
fi
ln -snfv ${HOME}/.vim ${HOME}/.config/nvim/
ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
