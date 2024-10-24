export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm-global"
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
export DOTFILES_REPO_PATH="${HOME}/dotfiles"
eval "$(sheldon source)"

function imgpaste_file(){
  pngpaste image.png
  echo image.png is created
}

zle -N imgpaste_file
bindkey "^V" imgpaste_file
. "$HOME/.rye/env"


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias slamdunk="open ~/Hobby/THE-FIRST-SLAM-DUNK/FULL.mp4"

PATH="$PATH:/opt/homebrew/bin"
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
PATH="$PATH:/$HOME/go/bin"
PATH="$PATH:/Users/yuma/.cargo/bin"
export PATH="/Users/yuma/.deno/bin:$PATH"

alias vim=nvim
alias q=exit
alias vz='vim ~/.zshrc'
alias vw='vim ~/.config/wezterm/wezterm.lua'
alias v='vim .'
alias ez='exec zsh'
alias vv='vim ~/.config/nvim/init.lua'
alias ls='exa -a'
alias tree='exa --tree'
alias ql='qlmanage -p "$@" >& /dev/null'

export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
eval "$(starship init zsh)"
. "$HOME/.cargo/env"
. "$HOME/.local/zsh/docker.zsh"

export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
stty erase '^?'

EDITOR=nvim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export FZF_DEFAULT_OPTS='--height 30% --border --select-1'

# PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="/Users/yuma/.local/bin:$PATH"
export PATH="/Users/yuma/Library/Python/3.8/bin:$PATH"
export PATH="/Users/yuma/Library/Python/3.9/bin:$PATH"

alias vz="nvim ~/.zshrc"
alias vv="nvim ~/.config/nvim/"
alias ..="cd .."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias .....="cd ../../../../.."
alias diff="colordiff -u"
alias spotify="spt"
export LESS='-R'
eval "$(frum init)"



alias pswd='ruby -rsecurerandom -e "puts SecureRandom.alphanumeric"|xargs echo -n|pbcopy'

# style
autoload -U compinit
compinit
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# export LANG=ja_JP.UTF-8
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

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

# function do_nothing(){}
# zle -N do_nothing
# bindkey "^D" do_nothing
setopt IGNORE_EOF

# zsh
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^U" backward-kill-line
bindkey "^K" backward-kill-line
bindkey "^H" backward-word
bindkey '\e[3~' delete-char

setopt auto_cd

plugins=(git zsh-syntax-highlighting)
plugins=(git)

# starship
source <("/opt/homebrew/bin/starship" init zsh --print-full-init)

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

alias Ag='Ag --hidden'

alias k=kubectl

alias mv='mv -i'
alias cp='cp -i'
alias vz='vim ~/.zshrc '
alias ve='vim ~/.zshenv '
alias ez='exec zsh'
alias se='source ~/.zshenv'

alias gs='git status'
alias gd='git diff'
alias gco='git checkout'
alias ga='git add .'
alias gaa='git add .'
alias gaaa='git add .'
alias gaaaa='git add .'
alias gaaaaa='git add .'
alias gaaaaaa='git add .'
alias gaaaaaaa='git add .'
alias gaaaaaaaa='git add .'
alias gc='git commit'
alias gcob="git checkout -b"
alias master="git checkout master"
alias main="git checkout main"

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

## functions
# ==================================

zle -N dm
bindkey "^o" dm

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

function cdr() {
  export TMP_CDR_DIR=$(pwd)

  while [[ $TMP_CDR_DIR != "/" ]]
  do
    if [ -e "$TMP_CDR_DIR/.git" ];then
      echo $TMP_CDR_DIR
      cd $TMP_CDR_DIR
      break
    else
      export TMP_CDR_DIR=$( dirname $TMP_CDR_DIR )
    fi
  done
  unset TMP_CDR_DIR
}

zle -N cd_parent
bindkey "^h" cd_parent
cd_parent () {
  cd ..
  zle accept-line
}
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# bun completions
[ -s "/Users/yuma/.bun/_bun" ] && source "/Users/yuma/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


eval "$(rbenv init -)"

