#!/bin/bash

export CODE=$HOME/Code
export EDITOR=$(command -v vim 2> /dev/null || echo /usr/bin/nano)
export HISTSIZE=
export HISTFILESIZE=

function bashrc() {
    $EDITOR "$CODE"/sh/bashrc/.bashrc && $EDITOR "$HOME"/.bashrc && source "$HOME"/.bashrc
}

# git utils
function gr() {
    echo "Password:"
    read -r -s password
    echo
    curl -u 7aske:"$password" https://api.github.com/user/repos -d "{\"name\":\"$1\"}"
    git init
    git remote add origin https://github.com/7aske/"$1".git
}

function clone() {
    if [ "$#" -eq 2 ]; then
        git clone https://github.com/"$1"/"$2"
    else
        git clone https://github.com/7aske/"$1"
    fi
}

function commit() { git add . && git commit -m "$@"; }

function drycommit() { git commit --branch --dry-run; }

function push() { git push origin "$(git branch | grep -e "^[\*]" | awk '{print $2}')"; }

function pull() { git pull origin "$(git branch | grep -e "^[\*]" | awk '{print $2}')"; }

function dpi() {
    val=$([ ! -z "$1" ] && echo "$1" || echo 96)
    if [ "$DESKTOP_SESSION" == "gnome" ]; then
        dconf write /org/gnome/desktop/interface/text-scaling-factor $(echo "scale=1; $val/96" | bc) 2> /dev/null
    elif [ "$DESKTOP_SESSION" == "xfce" ]; then
        xfconf-query -c xsettings -p /Xft/DPI -s "$val" 2> /dev/null
    fi

}

alias cls='clear -x'
alias autoremove='sudo pacman -R $(pacman -Qdtq)'
alias pacman='sudo pacman'
alias v='nvim'
alias n='nano'
alias ci='code-insiders'
alias c='vscodium || codium'
alias chrome='google-chrome-stable || chromium'
alias bat='bat --paging never'
alias myip='printf "%s\n" `curl -s ident.me`'
alias grep='grep --color=auto'
alias cpwd='pwd | xclip -sel c'
# navigation
alias dow='builtin cd $HOME/Downloads&& ls'
alias sha='builtin cd $HOME/Share&& ls'
alias doc='builtin cd $HOME/Documents&& ls'
alias pic='builtin cd $HOME/Pictures&& ls'
alias dro='builtin cd $HOME/Dropbox&& ls'
alias pub='builtin cd $HOME/Public&& ls'
alias shr='builtin cd /usr/share&& ls'
alias etc='builtin cd /etc/&& ls'
alias chc='cd "$("$CODE"/sh/utils-sh/chcode.sh)"'
alias chgs='cd "$("$CODE"/sh/utils-sh/chgs.sh)" && echo -e "\ngit status -s\n"; git status -s'
# misc
alias rsrc='source ~/.bashrc'
# ls
alias ls='ls --color=auto -lpvh --group-directories-first'
alias la='ls --color=auto -lApvh --group-directories-first'

# personal utils
alias gs="$CODE"/c/cgs/build/cgs

# laptop misc
alias backl='xbacklight -set'
alias bell='xset -b'

# eg. cd ... to jump back two directories
function cd() {
    case $1 in
    ..)
        builtin cd .. && ls
        ;;
    ...)
        builtin cd ../.. && ls
        ;;
    ....)
        builtin cd ../../.. && ls
        ;;
    .....)
        builtin cd ../../../../ && ls
        ;;
    *)
        builtin cd "$@" && ls
        ;;
    esac
}

function e() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
    Linux*) machine=Linux ;;
    Darwin*) machine=Mac ;;
    CYGWIN*) machine=Cygwin ;;
    MINGW*) machine=MinGw ;;
    *) machine="UNKNOWN:${unameOut}" ;;
    esac
    if test "${machine}" = 'Linux'; then
        xdg-open "$@"
    elif test "${machine}" = 'Cygwin' || test "${machine}" = 'MinGw'; then
        explorer "$@" &
    else
        echo 'Unsupported OS'
    fi
}

# easier bandint connection
function bandit() {
    if [ -z "$2" ]; then
        ssh -p 2220 bandit"$1"@bandit.labs.overthewire.org
    else
        sshpass -p "$2" ssh -o StrictHostKeyChecking=no -p 2220 bandit"$1"@bandit.labs.overthewire.org
    fi
}
function code() {
    builtin cd "$CODE"/"$1"/"$2" && ls
}
compl() {
    COMPREPLY=()
    local word="${COMP_WORDS[COMP_CWORD]}"
    if [ "$COMP_CWORD" -eq 1 ]; then
        COMPREPLY=($(compgen -W "$(dir $CODE)" -- "$word"))
    else
        local words=("${COMP_WORDS[@]}")
        unset "words[0]"
        unset "words[$COMP_CWORD]"
        local completions=$(dir -F "$CODE"/"${words[*]}")
        COMPREPLY=($(compgen -W "$completions" -- "$word"))
    fi
}
complete -F compl code

# PS1 setup
if [ "$TERM" == "xterm-kitty" ]; then
    if [[ "$(id -u)" == "0" ]]; then
        export PS1='\[\033[01;31m\]>>=\u\[\033[01;37m\] \W \[\033[01;32m\]\[\033[01;33m\]$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")\[\033[01;31m\]=>\[\033[00m\] '
    else
        export PS1='\[\033[01;34m\]>>=\u\[\033[01;37m\] \W \[\033[01;32m\]\[\033[01;33m\]$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")\[\033[01;34m\]=>\[\033[00m\] '
    fi
else
    if [[ "$(id -u)" == "0" ]]; then
        export PS1='\[\033[01;31m\]\u\[\033[01;37m\] \W \[\033[01;32m\]\[\033[01;33m\]$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")\[\033[01;31m\]\$\[\033[00m\] '
    else
        export PS1='\[\033[01;34m\]\u\[\033[01;37m\] \W \[\033[01;32m\]\[\033[01;33m\]$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")\[\033[01;34m\]\$\[\033[00m\] '
    fi
fi

if grep SSH_CLIENT <(env) &>/dev/null; then
    clear -x
    neofetch --config ~/.config/neofetch/config_ssh.conf 2>/dev/null
    if [[ "$(id -u)" == "0" ]]; then
        export PS1='\[\033[01;31m\]\u@\h\[\033[01;37m\] \W \[\033[01;32m\]\[\033[01;33m\]$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")\[\033[01;31m\]\$\[\033[00m\] '
    else
        export PS1='\[\033[01;35m\]\u@\h\[\033[01;37m\] \W \[\033[01;32m\]\[\033[01;33m\]$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")\[\033[01;35m\]\$\[\033[00m\] '
    fi
fi
