export DOTFILES_REPO_PATH="${HOME}/dotfiles"

alias vim=nvim
export EDITOR=nvim

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

# zsh
autoload -U compinit
compinit
stty erase '^?'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
export LESS='-R'
# export LANG=ja_JP.UTF-8
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
stty erase '^?'
setopt share_history
setopt brace_ccl
setopt extended_glob
setopt print_eight_bit
setopt always_last_prompt
setopt complete_in_word
setopt magic_equal_subst
setopt interactive_comments
setopt auto_param_keys
setopt auto_menu
setopt list_types
setopt auto_param_slash
setopt mark_dirs
setopt nonomatch
autoload colors
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=100000000
export SAVEHIST=100000000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt IGNORE_EOF
setopt auto_cd

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^U" backward-kill-line
bindkey "^K" backward-kill-line
bindkey "^H" backward-word
bindkey '\e[3~' delete-char
bindkey "^O" dm
bindkey "^D" do_nothing


# ==================================
## alias
# ==================================
alias q=exit
alias vz='vim ~/.zshrc'
alias v='vim .'
alias ez='exec zsh'
alias vv='vim ~/.config/nvim/init.lua'
alias ls='exa -a'
alias tree='exa --tree'
alias ql='qlmanage -p "$@" >& /dev/null'
alias imgcat='img2sixel'
alias x='bun x'
alias ag="ag -u"
alias ls='exa -g --time-style=long-iso -a'
alias ll="ls -la"
alias tree="exa -T -a -I .git --git-ignore"
alias :q='exit'
alias q='exit'
alias mv='mv -i'
alias cp='cp -i'
alias vz='vim ~/.zshrc '
alias ve='vim ~/.zshenv '
alias ez='exec zsh'
alias se='source ~/.zshenv'
alias vz="nvim ~/.zshrc"
alias vv="nvim ~/.config/nvim/"
alias ..="cd .."
alias ...="cd ../../.."
alias spotify="spt"

alias b='bundle -j4'
alias be="bundle exec"

alias dk='docker'
alias dkc="docker compose"
alias dck="docker compose"
alias tf='terraform'
alias ql='qlmanage -p "$@" >& /dev/null'


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
