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
# zinit light yous/lime
zinit light rupa/z
zinit ice depth=1; zinit light romkatv/powerlevel10k

# ==================================
## End Zinit
# ==================================



# zs
alias vim=nvim

bindkey -v
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
export ZSH="/Users/yuma/.oh-my-zsh"
ZSH_THEME="zhann"
plugins=(git zsh-syntax-highlighting)
plugins=(git)

autoload -Uz compinit && compinit
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/versions/2.6.3/bin:$PATH"
export PATH="/Users/yuma/Library/Python/3.7/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export XDG_BASE_HOME="$HOME/.config"
export NVIM="$HOME/.config/nvim"
source ${HOME}/.cargo/env
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# rbenv
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
alias bewin="cd ~/ruby/bewin"
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
alias ll=
alias k="tree -C"
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

function _search_by_google(){
  word="$1"
  open "https://google.com/search?q=$word"
}
function _search_by_google(){
  word="$1"
  open "https://google.com/search?q=$word"
}
alias gg="_search_by_google"


