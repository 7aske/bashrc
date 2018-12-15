#
# ~/.bashrc
#

function speedtest (){
	curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
}
function bashrc (){
	nano $HOME/Documents/CODE/sh/bashrc/.bashrc && nano ~/.bashrc && exec bash
}
function code () {
	builtin cd $HOME/Documents/CODE/$1/$2 && ls
}
compl () {
    COMPREPLY=();
    local word="${COMP_WORDS[COMP_CWORD]}";
    if [ "$COMP_CWORD" -eq 1 ]; then
        COMPREPLY=($(compgen -W "$(dir $HOME/Documents/CODE)" -- "$word"));
    else
        local words=("${COMP_WORDS[@]}");
        unset words[0];
        unset words[$COMP_CWORD];
        local completions=$(dir -F $HOME/Documents/CODE/"${words[@]}");
        COMPREPLY=($(compgen -W "$completions" -- "$word"));
    fi
}
complete -F compl code
complete -F compl gg
complete -F compl gs
function gp () {
	git pull $1
}
function gg () {
	if [ $# -eq 1 ]
	then
		git add . && git commit -m "$@"
		git push
	else
		loc="$HOME/Documents/CODE/$1/$2"
		git -C $loc add . && git -C $loc commit -m "$3"
		git -C $loc push
	fi
}
function gs (){
	python $HOME/Documents/CODE/py/utils-py/gitstatus.py "$@"
}
function gf (){
	python $HOME/Documents/CODE/py/utils-py/gitfetch.py "$@"
}
function gr (){
	echo "Password:"
	read -s password
	echo
	curl -u 7aske:$password https://api.github.com/user/repos -d "{\"name\":\"$1\"}"
	git init
	git remote add origin https://github.com/7aske/$1.git
}
function clean (){
	python $HOME/Documents/CODE/py/utils-py/clean.py "$@"
}
function backup (){
	python $HOME/Documents/CODE/py/utils-py/backup.py "$@"
}
function clone (){
	git clone https://github.com/7aske/$1
}
function commit (){
	git add .&& git commit -m "$@"
}
function push (){
	git push "$@"
}
function cd (){
	echo $1
	case $1 in
		..)
			builtin cd ..;;
		...)	
			builtin cd ../..;;
		....)
			builtin cd ../../..;;
		*)
			builtin cd $1;;
	esac
	ls
}
#alias cd='cd_func'
alias c='code-insiders'
alias ls='ls --color=auto -gGapvh --group-directories-first'
alias dow='builtin cd $HOME/Downloads'
alias sha='builtin cd $HOME/Share'
alias doc='builtin cd $HOME/Documents'
alias pic='builtin cd $HOME/Pictures'
alias dro='builtin cd $HOME/Dropbox'
alias pub='builtin cd $HOME/Public'
alias shr='builtin cd /usr/share'
alias wol='wakemeonlan'
alias dserver='builtin cd $HOME/Documents/CODE/js/deployment-server && npm start'
function e () {
	unameOut="$(uname -s)"
	case "${unameOut}" in
		Linux*)     machine=Linux;;
		Darwin*)    machine=Mac;;
		CYGWIN*)    machine=Cygwin;;
		MINGW*)     machine=MinGw;;
		*)          machine="UNKNOWN:${unameOut}"
	esac
	if test ${machine} = 'Linux'; then
		nautilus "$@"&
	else
		explorer "$@"&
	fi
}

LANG="en_US.UTF-8"
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

function python(){
	unameOut="$(uname -s)"
	case "${unameOut}" in
		Linux*)     machine=Linux;;
		Darwin*)    machine=Mac;;
		CYGWIN*)    machine=Cygwin;;
		MINGW*)     machine=MinGw;;
		*)          machine="UNKNOWN:${unameOut}"
	esac
	echo ${machine}
	if test ${machine} = 'MinGw'; then
		winpty python.exe "$@"
	else
		python3 "$@"
	fi
}


