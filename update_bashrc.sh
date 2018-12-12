#!/bin/bash
DIR="$HOME/Documents/CODE"
brc="source \$HOME/Documents/CODE/sh/bashrc/.bashrc"

function init {
    if grep "$brc" "$HOME/.bashrc"
    then
        exec bash
    else 
        echo "$brc" >> "$HOME/.bashrc"
        exec bash
    fi
}

if [ -d "$DIR" ]; then
    init

else
    mkdir -p "$DIR/sh"&& git clone https://github.com./7aske/bashrc "$DIR/sh/bashrc"
    init
fi
