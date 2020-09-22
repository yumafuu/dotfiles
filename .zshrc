# ==================================
## Zinit
# ==================================
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

eval "$(starship init zsh)"
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit light zdharma/fast-syntax-highlighting
zinit light paulirish/git-open
zinit light starship/starship

# ==================================
## End Zinit
# ==================================

# style
autoload -U compinit
compinit
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
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
autoload colors

# zs
alias vim=nvim
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^U" backward-kill-line
bindkey "^K" backward-kill-line

setopt auto_cd

bindkey -v
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
export ZSH="/Users/yuma/.oh-my-zsh"
# ZSH_THEME="zhann"
plugins=(git zsh-syntax-highlighting)
plugins=(git)

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/versions/2.6.3/bin:$PATH"
export PATH="/Users/yuma/Library/Python/3.7/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export XDG_BASE_HOME="$HOME/.config"
export NVIM="$HOME/.config/nvim"
source ${HOME}/.cargo/env
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# rbenv
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"


# node.js
export PATH=$HOME/.nodebrew/current/bin:$PATH

# yarn
export PATH="$HOME/.yarn/bin:$PATH"


# go
export GOPATH=$HOME/go
# export GOENV_ROOT=$HOME/.goenv
# export PATH=$GOENV_ROOT/bin:$PATH
# export PATH=$HOME/.goenv/bin:$PATH
export PATH="$GOPATH/bin:$PATH"
# export GOENV_DISABLE_GOPATH=1
# eval "$(goenv init -)"

# if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
#PS1='$(kube_ps1)'$PS1

# export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

# ==================================
## alias
# ==================================
alias airpods="BluetoothConnector -c ac-90-85-eb-4f-7c"
alias atcoder="cd ~/atcoder"
alias down="cd ~/Downloads"
alias ag="ag -u"
alias todo="vim ~/.todo.txt"
alias rust="cd ~/rust"
alias placy="cd ~/ruby/placy/Placy-api"
alias mos="cd ~/ruby/mos/"
alias mosapi="cd ~/ruby/mos/mos-api"
alias cha="cd ~/ruby/chieru/chieru_api"
alias chr="cd ~/ruby/chieru/chieru-api-recommend"
alias bewin="cd ~/go/src/bewin"
alias acs="cd ~/ruby/azucal/acs"

functions mosp(){
  echo -n AdminPassword1234 | pbcopy
}
functions chp() {
  echo $CHIERU_MYSQL_PASSWORD | pbcopy
}
functions sbbp() {
  echo $SBB_MYSQL_PASSWORD | pbcopy
}

alias ls='exa -g --time-style=long-iso'
alias ll="ls -l"
alias k="tree -C -a -I '.git|node_modules|cache|test_*'"
alias kill9="kill -9"
alias -g P='| pbcopy'
alias -g G='| grep'
alias :q='exit'
alias :w='echo "hahaha"'
alias :wq='echo "I am not vim!"'

alias Ag='Ag --hidden'

alias vims='vim -p `git diff --name-only`'
alias vimc='vim -p `git conflicts`'
alias vv='vim ~/.config/nvim/init.vim'
alias vmy='vim /etc/mysql/my.conf'

alias mv='mv -i'
alias vz='vim ~/.zshrc '
alias ve='vim ~/.zshenv '
alias sz='source ~/.zshrc'
alias se='source ~/.zshenv'

alias gs='git status'
alias gd='git diff'
alias gco='git checkout'
alias gaa='git add .'
alias gc='git commit'
alias gcob="git checkout -b"
alias gush='git push origin $(git branch | grep "*" | sed -e "s/^\*\s*//g")'
alias gull='git pull --rebase origin $(git branch | grep "*" | sed -e "s/^\*\s*//g")'
alias dev="git checkout dev"
alias stg="git checkout stg"
alias master="git checkout master"
alias co='git checkout $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

alias py='python3'

alias ra='rails'
alias b='bundle'
alias be='bundle exec'
alias bh='bundle exec hanami'
alias rubo="bundle exec rubocop"
alias ruboa="bundle exec rubocop -a"
alias dk='docker'
alias dkps="docker ps"

alias tenki="curl wttr.in"
alias now="date "+%H:%M:%S"&&cal"
alias aqua="asciiquarium"

alias ku="kubectl"
alias kpods="kubectl get pods"
alias ksvc="kubectl get services"
alias klogs="kubectl logs"
alias gos="cd ~/go/src"
alias sbb="cd ~/go/src/linebot-smartarch"
alias gr="go run"
alias gpr= "hub pull-request"
alias bo="bookmark-go"
alias bk="bookmark-go show | fzf | bookmark-go open"
alias f="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | xargs nvim"
alias tf='terraform'
alias curlt='curl -so /dev/nul -w "http_code: %{http_code}\ntime_namelookup: %{time_namelookup}\ntime_connect: %{time_connect}\ntime_appconnect: %{time_appconnect}\ntime_pretransfer: %{time_pretransfer}\ntime_starttransfer: %{time_starttransfer}\ntime_total: %{time_total}\n"'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yuma/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yuma/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yuma/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yuma/google-cloud-sdk/completion.zsh.inc'; fi

# ==================================
## functions
# ==================================

# mkdir then cd
function _makedir_then_changedir(){
  dir=$1
  mkdir -p $dir
  cd $dir
 }
alias mcdir='_makedir_then_changedir'

function _search_on_google(){
  words="$(IFS="+"; echo "${${@:1}[*]}")"
  if [ "$words" != "" ]; then
    open "https://google.com/search?q=$words"
  fi
}
alias gg="_search_on_google"

