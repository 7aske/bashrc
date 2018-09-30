#
# ~/.bashrc
#

function speedtest (){
	curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
}
function bashrc (){
	nano ~/.bashrc && exec bash
	#sh $HOME/Documents/CODE/sh/bashrc/update_bashrc.sh
}
function code () {
	 cd $HOME/Documents/CODE/$1/$2;	
}
function gp () {
	git pull $1
}
function gg () {
	git add . && git commit -m $1
	git push -u origin master
}
function prune (){
	python3 $HOME/Documents/CODE/py/utils-py/prune.py $1
}
function backup (){
	python3 $HOME/Documents/CODE/py/utils-py/backup.py $1 $2 $3
}
function gr (){
	echo $1
	curl -u '7aske' https://api.github.com/user/repos -d "{\"name\":\"$1\"}"
	git init
	git remote add origin https://github.com/7aske/$1.git
}
alias c='code-insiders'
alias ls='ls --color=auto -gGapv'
alias dow='cd $HOME/Downloads'
alias sha='cd $HOME/Share'
alias doc='cd $HOME/Documents'
alias pic='cd $HOME/Pictures'
alias dro='cd $HOME/Dropbox'
alias pub='cd $HOME/Public'
alias k='sudo krusader'
alias e='explorer'
alias dserver='cd $HOME/Documents/CODE/js/deployment-server && npm start'


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
		winpty python.exe $1 $2 $3
	fi
}


