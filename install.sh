#!/bin/bash

# dotfiles
DOTPATH=~/.dotfiles
for file in .??*
do
    [ ${file} = ".git" ] && continue
	[ ${file} = ".gitignore" ] && continue
	[ ${file} = ".config" ] && continue

    ln -snfv $DOTPATH/${file} ${HOME}/${file}
done
ln -snfv ${DOTPATH}/.config/nvim ${HOME}/.config/nvim

# dir
if [[ ! -e ${HOME}/local ]]; then
	mkdir ${HOME}/local
fi
if [[ ! -e ${HOME}/bin ]]; then
	mkdir ${HOME}/bin
fi
