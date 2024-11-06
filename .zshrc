export DOTFILES_REPO_PATH="${HOME}/dotfiles"

alias vim=nvim
export EDITOR=nvim

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

# cargo
if [ -f "$HOME/.cargo.env" ]; then
  . "$HOME/.cargo.env"
fi

# rye
if [ -f "$HOME/.rye/env" ]; then
  . "$HOME/.rye/env"
fi

# asdf
if [ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# aqua
alias a="aqua"
export AQUA_GLOBAL_CONFIG=$HOME/dotfiles/aqua/aqua.yaml
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm-global"
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
export PATH="$(aqua root-dir)/bin:$PATH"
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

# fzf
source <(fzf --zsh)
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export FZF_DEFAULT_OPTS="--height 50% --border --color=pointer:blue"

# PATH
PATH=$HOME/.cargo/bin:$PATH
PATH="${PATH}:${HOME}/.krew/bin"
PATH="/Users/yuma/.local/bin:$PATH"
PATH="/Users/yuma/Library/Python/3.8/bin:$PATH"
PATH="/Users/yuma/Library/Python/3.9/bin:$PATH"
PATH="$PATH:/$HOME/go/bin"
PATH="$PATH:/Users/yuma/.cargo/bin"
PATH="/Users/yuma/.deno/bin:$PATH"
export PATH

alias vz="nvim ~/.zshrc"
alias vv="nvim ~/.config/nvim/"
alias ..="cd .."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias .....="cd ../../../../.."
alias diff="colordiff -u"
alias spotify="spt"
export LESS='-R'


alias pswd='ruby -rsecurerandom -e "puts SecureRandom.alphanumeric"|xargs echo -n|pbcopy'

# zsh
autoload -U compinit
compinit
stty erase '^?'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
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

function do_nothing(){}
zle -N do_nothing
bindkey "^D" do_nothing
setopt IGNORE_EOF

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^U" backward-kill-line
bindkey "^K" backward-kill-line
bindkey "^H" backward-word
bindkey '\e[3~' delete-char

setopt auto_cd

# ==================================
## alias
# ==================================
alias so="source"
alias ...=../..
alias ....=../../..
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
alias whcih="which"

alias gush='
  git push origin \
  $(
    git branch | \
      grep "*" | \
      sed -e "s/^\*\s*//g" \
    ) \
  '
alias gul='
  git pull --rebase origin \
  $(
    git branch | \
      grep "*" | \
      sed -e "s/^\*\s*//g" \
    ) \
  '

function g-branch(){
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

alias b='bundle -j4'
alias be="bundle exec"

alias dk='docker'
alias dkc="docker compose"
alias dck="docker compose"

alias tf='terraform'
alias oepn="open"

alias ql='qlmanage -p "$@" >& /dev/null'

# functions
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
bindkey -e

function dm(){
  file=$HOME/.dm.csv
  touch $file

  if [[ $1 = "a" ]]; then
    dir=`/bin/pwd`
    read "name?name: "
    if [[ $name == "" ]];then
      name=$dir
    fi
    echo $dir,$name | sed "s/\/Users\/yuma/\~/g" | tee -a $file
    return
  fi

  if [[ $1 = "e" ]]; then
    $EDITOR $file
    return
  fi

  t=`cat $file | \
    fzf -d, --with-nth 2 --preview "echo {} | cut -d , -f 1" | \
    sed "s/\~/\/Users\/yuma/g"`
  if [[ $t = "" ]]; then
    return
  fi

  dir=`echo ${t} | cut -d , -f 1`
  cd $dir
  echo
}
zle -N dm
bindkey "^o" dm

function cd_target(){
  d=$( \
    fd --type d -H \
    -E .git \
    -E node_modules \
    -E .terragrunt-cache \
    | fzf --select-1 --preview 'exa -T --git-ignore {}' )

  if [[ $d = "" ]]; then
    return
  fi

  cd $d
}

zle -N cd_target
bindkey "^k" cd_target

zle -N cd_parent
bindkey "^h" cd_parent
cd_parent () {
  cd ..
  zle accept-line
}
zle -N cd_back
bindkey "^k" cd_back
cd_back() {
  cd - > /dev/null
  zle accept-line
}

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# bun completions
[ -s "/Users/yuma/.bun/_bun" ] && source "/Users/yuma/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pure
autoload -U promptinit; promptinit
export PURE_CMD_MAX_EXEC_TIME=1
zstyle ':prompt:pure:path' color '#9C9C9C'
zstyle ':prompt:pure:git:*' color '#8C8C8D'
zstyle ':prompt:pure:prompt:success' color blue

# rbenv
eval "$(rbenv init -)"


# sheldon
eval "$(sheldon source)"

# tmux
export TMUX_PLUGIN_MANAGER_PATH="~/.tmux/plugins"
