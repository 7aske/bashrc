function gg () {
    git add . && git commit -m "$@" && git push -u origin master
}
function gg () {
    git pull "$@"
}
alias code='cd C:\\Users\\student\\Documents\\7aske\\CODE'
function c () {
    C:\\dev\\Microsoft\ VS\ Code\\bin\\code "$@"
}
alias e='explorer'
alias doc='cd $HOME/Documents'
alias dow='cd $HOME/Downloads'
alias ls='ls --color=auto -gGapv