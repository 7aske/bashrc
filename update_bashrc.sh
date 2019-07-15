#!/bin/sh
DIR="$HOME/Code"
brc="source \$HOME/Code/sh/bashrc/rc"

function init {
    if grep "$brc" "$HOME/.bashrc"; then
        echo "Nothing to do."
    else 
        echo "$brc" >> "$HOME/.bashrc"
        exec bash
    fi
}

if [ -d "$DIR" ]; then
    init
else
    mkdir -p "$DIR/sh"&& git clone https://github.com/7aske/bashrc "$DIR/sh/bashrc"
    init
fi
