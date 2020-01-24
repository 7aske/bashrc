#!/usr/bin/env sh

SRCSTR="source \$HOME/Code/sh/bashrc/.bashrc"

[ ! -e "$HOME"/Code/sh ] && mkdir -p "$HOME"/Code/sh/

if [ ! -e "$HOME/Code/sh/bashrc" ]; then
    git -C "$HOME"/Code/sh clone https://github.com/7aske/bashrc
fi	

[ ! -e "$HOME"/.bashrc ] && touch "$HOME"/.bashrc

if ! grep "$SRCSTR" "$HOME/.bashrc" 2>&1>/dev/null; then
    echo "$SRCSTR" >>"$HOME/.bashrc"
    source "$HOME/Code/sh/bashrc/.bashrc"
fi
