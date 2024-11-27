export DOTFILES_REPO_PATH="${HOME}/dotfiles"
export EDITOR=nvim

# vim
alias vim=nvim

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export LIBRARY_PATH="/opt/homebrew/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/opt/homebrew/lib:$LD_LIBRARY_PATH"

# asdf
asdf_sh=/opt/homebrew/opt/asdf/libexec/asdf.sh
[ -s $asdf_sh ] && source $asdf_sh
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export PATH="$(go env GOPATH)/bin:$PATH"

# aqua (make sure load after asdf)
alias a="aqua"
export AQUA_GLOBAL_CONFIG=$HOME/dotfiles/aqua/aqua.yaml
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm-global"
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
export PATH="$(aqua root-dir)/bin:$PATH"

# sheldon
command -v sheldon >/dev/null && eval "$(sheldon source)"

# cargo
[ -s "/Users/yuma/.cargo.env" ] && source "/Users/yuma/.cargo.env"
export PATH=$HOME/.cargo/bin:$PATH

# rye
[ -s "$HOME/.rye/env" ] && source "$HOME/.rye/env"

# deno
export PATH="/Users/yuma/.deno/bin:$PATH"

# fzf
source <(fzf --zsh)
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export FZF_DEFAULT_OPTS="--height 50% --border --color=pointer:blue"

# go
export PATH="$PATH:$HOME/go/bin"

# bin
export PATH="$HOME/.local/bin:$PATH"

# bun
[ -s "/Users/yuma/.bun/_bun" ] && source "/Users/yuma/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pure
export PURE_CMD_MAX_EXEC_TIME=1
zstyle ':prompt:pure:path' color '#9C9C9C'
zstyle ':prompt:pure:git:*' color '#8C8C8D'
zstyle ':prompt:pure:prompt:success' color blue

# bindkey
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^U" backward-kill-line
bindkey "^K" backward-kill-line
bindkey "^H" backward-word
bindkey '\e[3~' delete-char
bindkey "^D" do_nothing
bindkey "^k" cd_target
bindkey "^h" cd_parent
bindkey "^k" cd_back
bindkey "^o" _fzf_cd_ghq

# rbenv
command -v rbenv >/dev/null && eval "$(rbenv init -)"

# tmux
export TMUX_PLUGIN_MANAGER_PATH="~/.tmux/plugins"

# psql
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
