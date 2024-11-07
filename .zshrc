export DOTFILES_REPO_PATH="${HOME}/dotfiles"
export EDITOR=nvim

# vim
alias vim=nvim

# sheldon
eval "$(sheldon source)"

# aqua
alias a="aqua"
export AQUA_GLOBAL_CONFIG=$HOME/dotfiles/aqua/aqua.yaml
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm-global"
PATH=$NPM_CONFIG_PREFIX/bin:$PATH
PATH="$(aqua root-dir)/bin:$PATH"

# homebrew
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# cargo
[ -s "/Users/yuma/.cargo.env" ] && source "/Users/yuma/.cargo.env"
PATH=$HOME/.cargo/bin:$PATH

# rye
[ -s "$HOME/.rye/env" ] && source "$HOME/.rye/env"

# asdf
asdf_sh=/opt/homebrew/opt/asdf/asdf.sh
[ -s $asdf_sh ] && source $asdf_sh

# deno
PATH="/Users/yuma/.deno/bin:$PATH"

# fzf
source <(fzf --zsh)
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export FZF_DEFAULT_OPTS="--height 50% --border --color=pointer:blue"

# go
PATH="$PATH:/$HOME/go/bin"

# bin
PATH="/Users/yuma/.local/bin:$PATH"

# bun
[ -s "/Users/yuma/.bun/_bun" ] && source "/Users/yuma/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
PATH="$BUN_INSTALL/bin:$PATH"

# pure
autoload -U promptinit; promptinit
export PURE_CMD_MAX_EXEC_TIME=1
zstyle ':prompt:pure:path' color '#9C9C9C'
zstyle ':prompt:pure:git:*' color '#8C8C8D'
zstyle ':prompt:pure:prompt:success' color blue

# rbenv
eval "$(rbenv init -)"

# tmux
export TMUX_PLUGIN_MANAGER_PATH="~/.tmux/plugins"

# path
export PATH
