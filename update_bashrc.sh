#!/bin/bash
loc="source \$HOME/Documents/CODE/sh/bashrc/.bashrc"
if grep $loc ~/.bashrc
then
    exec bash
else 
    echo "$loc" >> ~/.bashrc
    exec bash
fi