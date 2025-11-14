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
alias vim='nvim'
alias v="vim ."
alias vz='vim ~/dotfiles/.zshrc '
alias ve='vim ~/.zshenv '
alias vv='vim ~/.config/nvim/lua/plugins.lua'
alias vd='vim -p $(git diff --name-only)'

# ai
alias c="crush"
alias ai="mods -m"

## gwq
alias gq="gwq"

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
alias aia="aqua i -a -l"

# go
alias gogen="go generate"
alias gorun="go run"
alias gotest="go test"
alias gotestv="go test -v"
alias gtv="go test -v"

# git
alias g="git"
alias gco="git checkout"
alias gcdf='git clean -df'
alias ghco='gh pr checkout'

## push
alias gul='git fetch && git pull --rebase origin $(git branch --show-current)'
gush() {
  local branch
  branch=$(git branch --show-current)

  if git ls-remote --exit-code origin "$branch" >/dev/null 2>&1; then
    echo "🔄 Remote branch '$branch' found. Rebasing & pushing..."
    git pull --rebase origin "$branch" && git push origin "$branch"
  else
    echo "🌱 Remote branch '$branch' not found. Creating it on origin..."
    git push --set-upstream origin "$branch"
  fi
}
alias gushf='gush -f'

## status
alias gs='git status'
alias gd='git diff --no-prefix'

## add
alias ga='git add .'
alias gaa='git add .'
alias gaaa='git add .'

## commit
gc() { git commit -m "$*" }

## branch to command
alias master="git checkout master"
alias main="git checkout main"

# fast
alias fast="bun x fast-cli --single-line --upload"

# fzf-make
alias fm='fzf-make'
alias fr='fzf-make repeat'
alias fh='fzf-make history'
