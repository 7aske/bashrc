#!/bin/bash

loc="source \$HOME/Documents/CODE/sh/bashrc/.bashrc"
if grep "$loc" "$HOME/.bashrc"
then
    exec bash
else 
    echo "$loc" >> "$HOME/.bashrc"
    exec bash
fi