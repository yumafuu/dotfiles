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
# alias v="fzf|xargs -r nvim"
alias v="nvim ."
alias vz='nvim ~/dotfiles/.zshrc '
alias ve='nvim ~/.zshenv '
alias vv='vim ~/.config/nvim/lua/plugins.lua'
alias vd='vim -p $(git diff --name-only)'

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
