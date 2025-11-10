# config
export DOTFILES_REPO_PATH="${HOME}/dotfiles"
export XDG_CONFIG_HOME="${HOME}/.config"

# sheldon ---
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"
## cache
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache sheldon_toml

# vim
alias vim=nvim
export EDITOR=nvim

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export LIBRARY_PATH="/opt/homebrew/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/opt/homebrew/lib:$LD_LIBRARY_PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# aqua
alias a="aqua"
export AQUA_GLOBAL_CONFIG=$HOME/dotfiles/aqua/aqua.yaml
export NPM_CONFIG_PREFIX=${XDG_DATA_HOME:-$HOME/.local/share}/npm-global
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
export PATH="$(aqua root-dir)/bin:$PATH"

# mise
# eval "$(mise activate zsh)"
# eval "$(mise hook-env)"

# go
export PATH="$(go env GOPATH)/bin:$PATH"

# cargo
export PATH=$HOME/.cargo/bin:$PATH

# deno
export PATH="$HOME/.deno/bin:$PATH"

# local
export PATH="$HOME/.local/bin:$PATH"

# fzf
source <(fzf --zsh)
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export FZF_DEFAULT_OPTS="--height 50% --border --color=pointer:blue"

# go
export PATH="$PATH:$HOME/go/bin"

# bin
export PATH="$PATH:$HOME/.local/bin"

# bun
source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pure
autoload -U promptinit; promptinit
export PURE_CMD_MAX_EXEC_TIME=0.5
export PURE_PROMPT_SYMBOL=">"
zstyle ':prompt:pure:path' color '#9C9C9C'
zstyle ':prompt:pure:git:*' color '#d3d3d3'
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
bindkey "^o" ghq-fzf

# rbenv
# command -v rbenv >/dev/null && eval "$(rbenv init -)"

# tmux
export TMUX_PLUGIN_MANAGER_PATH="~/.tmux/plugins"

# psql
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# kw
export PATH="$HOME/ghq/github.com/knowledge-work/knowledgework/local/bin:$PATH"
export PATH="$HOME/ghq/github.com/knowledge-work/knowledgework/.yuma/bin:$PATH"

# Windsurf
export PATH="/Users/yuma.ishikawa/.codeium/windsurf/bin:$PATH"

# if type zprof > /dev/null 2>&1; then
#   zprof | cat
# fi
