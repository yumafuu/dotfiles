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

# exa
alias ls='exa -g --time-style=long-iso -a'
alias ez='exec zsh'
alias ll="exa -la"
alias tree="exa -T -a -I .git --git-ignore"

# vim
alias v='nvim .'
alias vv="nvim ~/.config/nvim/"
alias vz='nvim ~/.zshrc '
alias ve='nvim ~/.zshenv '
alias vv='vim ~/.config/nvim/init.lua'

# spotify_player
alias spotify="spt"
alias spt="spotify_player"

# bundle
alias b='bundle -j4'
alias be="bundle exec"

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

