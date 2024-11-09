function g-branch() {
  git branch -a |
    sed -e "s/[ ,\*]//g" |
    sed -e "s/remotes\/origin\///g" |
    sed -e "s/HEAD->//g" |
    sort -u |
    fzf |
    tr -d '\n'
}
alias checkout="g-branch | xargs git checkout"
alias co=checkout
alias gush='git push origin $( git branch | grep "*" | sed -e "s/^\*\s*//g" ) '
alias gul='git pull --rebase origin  \
  $( git branch | grep "*" | sed -e "s/^\*\s*//g" )  '
alias gs='git status'
alias gd='git diff --no-prefix'
alias gco='git checkout'
alias ga='git add .'
alias gaa='git add .'
alias gaaa='git add .'
alias gaaaa='git add .'
alias gc='git commit'
alias gcob="git checkout -b"
alias master="git checkout master"
alias main="git checkout main"
