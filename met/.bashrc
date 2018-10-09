function gg () {
    git add . && git commit -m "$@" && git push -u origin master
}
function gp () {
    git pull "$@"
}
function code () {
    cd C:\\Users\\student\\Documents\\7aske\\CODE\\$1\\$2
}
function c () {
    C:\\dev\\Microsoft\ VS\ Code\\bin\\code "$@"
}
alias e='explorer'
alias doc='cd $HOME/Documents'
alias dow='cd $HOME/Downloads'
alias ls='ls --color=auto -gGapv'
alias javac='C:\\Program\ Files\\Java\\jdk1.8.0_172\\bin\\javac.exe'
alias java='C:\\Program\ Files\\Java\\jdk1.8.0_172\\bin\\java.exe'
