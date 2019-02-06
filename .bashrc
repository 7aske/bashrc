#
# ~/.bashrc
#
alias ls='ls --color=auto -gGapvh --group-directories-first'

function speedtest (){
	curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
}
function bashrc (){
	nano $HOME/Documents/CODE/sh/bashrc/.bashrc && nano ~/.bashrc && exec bash
}
function code () {
	builtin cd $HOME/Documents/CODE/$1/$2 && ls
}
export CODE=$HOME/Documents/CODE
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
function renamer (){
	python $HOME/Documents/CODE/py/utils-py/renamer.py "$@"
}
function instaupload(){
	python $HOME/Documents/CODE/py/utils-py/instagramupload.py "$@"
}
function backup (){
	python $HOME/Documents/CODE/py/utils-py/backup.py "$@"
}
function clone (){
	if [ "$#" -eq 2 ]
	then
		git clone https://github.com/$1/$1
	else
		git clone https://github.com/7aske/$2
	fi
}
function commit (){
	git add .&& git commit -m "$@"
}
function drycommit (){
	git commit --branch --dry-run
}
function push (){
	git push "$@"
}
function pull (){
	git pull "$@"
}
function git-srv-init () {
	cmd1="mkdir -p /srv/repos/$1.git"
	cmd2="cd /srv/repos/$1.git && git init --bare"
	ssh git@nik-srv $cmd1&&
	ssh git@nik-srv $cmd2&& echo Done.
}
function git-srv-add-remote () {
	git remote add nik-srv git@nik-srv:/srv/repos/$1.git
}
function cd (){
	case $1 in
		..)
			builtin cd ..&& ls;;
		...)	
			builtin cd ../..&& ls;;
		....)
			builtin cd ../../..&& ls;;
		.....)
			builtin cd ../../../../&& ls;;
		*)
			builtin cd $1&& ls;;
	esac
}
function aur (){
	git clone https://aur.archlinux.org/$1.git ~/Downloads/$1&& 
cd ~/Downloads/$1&& makepkg -sirc
}
alias autoremove='sudo pacman -R $(pacman -Qdtq)'
alias ci='code-insiders'
alias dow='builtin cd $HOME/Downloads&& ls'
alias sha='builtin cd $HOME/Share&& ls'
alias doc='builtin cd $HOME/Documents&& ls'
alias pic='builtin cd $HOME/Pictures&& ls'
alias dro='builtin cd $HOME/Dropbox&& ls'
alias pub='builtin cd $HOME/Public&& ls'
alias shr='builtin cd /usr/share&& ls'
alias drc='builtin cd ~/.wine/drive_c&& ls'
alias etc='builtin cd /etc/&& ls'
alias go-serve='$HOME/Documents/CODE/go/basic-http-server-go/out/httpserver'
#alias dserver='builtin cd $HOME/Documents/CODE/js/deployment-server && npm start'
alias backl='xbacklight -set'
#alias hdmion='sudo intel-virtual-output'
#alias hdmioff='sudo pkill intel-virtual-o'

function hdmi() {
	case $1 in
		on*)	sudo intel-virtual-output;;
		off*)	sudo pkill intel-virtual-o;;
		*)	echo "usage: hdmi [on|off]";;
	esac
}
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
		nemo "$@"& disown -a
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


#function battery(){
#	echo $1
#	if [ "$1" = "true" ]; then
#		echo Battery
#		sudo tlp true
#		sudo pm-powersave true
#	else	
#		echo AC
#		sudo tlp false
#		sudo pm-powersave false
#	fi
#}
