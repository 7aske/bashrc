#!/bin/bash

DIR="$HOME/Code"
brc="source \$HOME/Code/sh/bashrc/rc"

if ! [ -d "$DIR" ]; then
    mkdir -p "$DIR/sh" && git clone https://github.com/7aske/bashrc "$DIR/sh/bashrc"
fi

if grep "$brc" "$HOME/.bashrc"; then
    echo "Nothing to do."
else
    echo "$brc" >>"$HOME/.bashrc"
    source "$HOME/.bashrc"
fi
