# zsh
alias q=exit
alias x='bun x'
alias ag="ag -u"
alias :q='exit'
alias q='exit'
alias mv='mv -i'
alias cp='cp -i'
alias ez='exec zsh'
alias se='source ~/.zshenv'
alias ..="cd .."
alias ...="cd ../../.."
alias cdr='cd "$(git rev-parse --show-toplevel)"'

# exz
alias ls='eza -g --time-style=long-iso -a'
alias ll="eza -la --icons --time-style=long-iso"
alias tree="eza -T -a -I .git --git-ignore"

# ez
alias ez='exec zsh'

# vim
# nvim() {
#   # pwdkey is $(pwd) replace / to .
#   local pwdkey=$(pwd | tr '/' '.')
#   local sock="/tmp/nvim-$pwdkey.sock"
#   command nvim --listen "$sock" "$@"
# }
alias vim='nvim'
alias v="vim ."
alias vz='vim ~/dotfiles/.zshrc '
alias ve='vim ~/.zshenv '
alias vv='vim ~/.config/nvim/lua/plugins.lua'
alias vd='vim -p $(git diff --name-only)'

# ai
alias c="claude"
alias gw="gwq"

# spotify_player
alias spotify="spt"
alias spt="spotify_player"

# docker
alias dk='docker'
alias dkc="docker compose"
alias dck="docker compose"

# terraform
alias tf='terraform'

# image
alias ql='qlmanage -p "$@" >& /dev/null'
alias imgcat='img2sixel'

# aqua
alias agi="aqua g -i"
alias ai="aqua i -l"
alias aia="aqua i -a -l"

# go
alias gogen="go generate"
alias gorun="go run"
alias gotest="go test"
alias gotestv="go test -v"
alias gtv="go test -v"

# git
## checkout
function g-branch-fzf() {
  git branch -a |
    sed -e "s/[ ,\*]//g" |
    sed -e "s/remotes\/origin\///g" |
    sed -e "s/HEAD->//g" |
    sort -u |
    fzf |
    tr -d '\n'
}

# FZF でブランチ選択 or 引数でブランチ作成／チェックアウト
co() {
  if [ $# -eq 0 ]; then
    # 引数なし：g-branch-fzf の結果を checkout
    g-branch-fzf | xargs git checkout
  else
    branch=$1
    # refs/heads に存在すれば checkout、なければ -b
    if git show-ref --verify --quiet "refs/heads/${branch}"; then
      git checkout "${branch}"
    else
      git checkout -b "${branch}"
    fi
  fi
}

alias g="git"
alias gco="git checkout"
alias gcdf='git clean -df'
alias ghco='gh pr checkout'

## push
alias gush='git push origin $( git branch | grep "*" | sed -e "s/^\*\s*//g" )'
alias gushf='gush -f'

## pull
alias gul='git pull --autostash --rebase origin $( git branch | grep "*" | sed -e "s/^\*\s*//g" )'

## status
alias gs='git status'
alias gd='git diff --no-prefix'

## add
alias ga='git add .'
alias gaa='git add .'
alias gaaa='git add .'

## commit
alias gc='git commit'

## branch to command
alias master="git checkout master"
alias main="git checkout main"
