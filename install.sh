#!/bin/bash

DOTPATH=~/.dotfiles

for file in .??*
do
    [ ${file} = ".git" ] && continue
	[ ${file} = ".gitignore" ] && continue
	[ ${file} = ".config" ] && continue

    ln -snfv $DOTPATH/${file} ${HOME}/${file}
done

# neovim
ln -snfv ${DOTPATH}/.config/nvim ${HOME}/.config/nvim
