# checkout
function g-branch-fzf() {
  git branch -a |
    sed -e "s/[ ,\*]//g" |
    sed -e "s/remotes\/origin\///g" |
    sed -e "s/HEAD->//g" |
    sort -u |
    fzf |
    tr -d '\n'
}
alias _gitCheckoutFuzzy="g-branch-fzf | xargs git checkout"
alias co=_gitCheckoutFuzzy
alias gco='git checkout'
alias gcob="git checkout -b"

# push
alias gush='git push origin $( git branch | grep "*" | sed -e "s/^\*\s*//g" )'
alias gushf='gush -f'

# pull
alias gul='git pull --autostash --rebase origin $( git branch | grep "*" | sed -e "s/^\*\s*//g" )'

# status
alias gs='git status'
alias gd='git diff --no-prefix'

# add
alias ga='git add .'
alias gaa='git add .'
alias gaaa='git add .'

# commit
alias gc='git commit'

# branch to command
alias master="git checkout master"
alias main="git checkout main"
