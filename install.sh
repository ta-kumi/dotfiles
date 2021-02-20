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

# tmux plugin
if [[ ! -d ${HOME}/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
fi

# dir
if [[ ! -d ${HOME}/local ]]; then
	mkdir ${HOME}/local
fi
if [[ ! -d ${HOME}/bin ]]; then
	mkdir ${HOME}/bin
fi
