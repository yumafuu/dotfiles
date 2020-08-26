# zs
alias vim=nvim

bindkey -v
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
export ZSH="/Users/yuma/.oh-my-zsh"
ZSH_THEME="zhann"
plugins=(git zsh-syntax-highlighting)
plugins=(git)
source $ZSH/oh-my-zsh.sh

autoload -Uz compinit && compinit
export PATH="/usr/local/bin:$PATH"
# export JAVA_HOME=`/usr/libexec/java_home`
# export PATH=${JAVA_HOME}/bin:$PATH
export PATH="$HOME/.rbenv/versions/2.6.3/bin:$PATH"
# export PATH="/usr/local/opt/swagger-codegen@2/bin:$PATH"
export PATH="/Users/yuma/Library/Python/3.7/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/mysql@5.6/lib"
# export CPPFLAGS="-I/usr/local/opt/mysql@5.6/include"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export XDG_BASE_HOME="$HOME/.config"
export NVIM="$HOME/.config/nvim"
source ${HOME}/.cargo/env

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
if which ruby >/dev/null && which gem >/dev/null; then
  PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


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

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
#PS1='$(kube_ps1)'$PS1

# export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

# ==================================
## alias
# ==================================
alias airpods="BluetoothConnector -c ac-90-85-eb-4f-7c"
alias airpodsd="BluetoothConnector -d ac-90-85-eb-4f-7c"
alias atcoder="cd ~/atcoder"
alias books="cd ~/books"
alias down="cd ~/Downloads"
alias ag="ag -u"
# alias todo="vim ~/.todo.md"
alias todo="vim ~/.todo.txt"
alias rust="cd ~/rust"
alias dezoo="cd ~/ruby/dezo"
alias scboo="cd ~/go/src/scbo"
alias sinapi="cd ~/ruby/sinapi"
alias tst="vim ~/code/test.rb"
alias rtst="ruby ~/code/test.rb"
alias exetst="ruby ~/code/test.rb"
alias fuya="cd ~/ruby/fuyano"
alias code="cd ~/code"
alias placy="cd ~/ruby/placy/Placy-api"
alias mos="cd ~/ruby/mos/"
alias mosmock="cd ~/ruby/mos/mos-mock-stoplight"
alias mosapi="cd ~/ruby/mos/mos-api"
alias ch="cd ~/ruby/chieru"
alias cha="cd ~/ruby/chieru/chieru_api"
alias chm="cd ~/ruby/chieru/chieru-api-mock"
alias chr="cd ~/ruby/chieru/chieru-api-recommend"
alias bewin="cd ~/ruby/bewin"

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
alias l1="ls -1"
alias k="tree -C"
alias -g P='| pbcopy'
alias -g G='| grep'
alias :q='exit'
alias :w='echo "hahaha"'
alias :wq='echo "I am not vim!"'

alias Ag='Ag --hidden'

alias bim='vim'
alias ゔぃm='vim'
alias びm='vim'
alias emacs="vim"
alias vims='vim -p `git diff --name-only`'
alias vimc='vim -p `git conflicts`'
alias vv='vim ~/.config/nvim/init.vim'
alias vmy='vim /etc/mysql/my.conf'
alias venv='vim .env'

alias mv='mv -i'
alias vr='vim ~/.test.rb '
alias rr='ruby ~/.test.rb '
alias vz='vim ~/.zshrc '
alias ve='vim ~/.zshenv '
alias sz='source ~/.zshrc'
alias se='source ~/.zshenv'

alias gs='git status'
alias gco='git checkout'
alias gco-='git checkout -'
alias gaa='git add .'
alias gc='git commit'
alias gcrubo='git commit -m"[fix] rubocop"'
alias gcob="git checkout -b"
alias gb='git branch | grep "*" | sed -e "s/^\*\s*//g"'
alias gush='git push origin $(git branch | grep "*" | sed -e "s/^\*\s*//g")'
alias gull='git pull --rebase origin $(git branch | grep "*" | sed -e "s/^\*\s*//g")'
alias dev="git checkout dev"
alias stg="git checkout stg"
alias master="git checkout master"
alias co='git checkout $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

alias python='python'
alias py='python3'

alias ra='rails'
alias h='hanami'
alias b='bundle'
alias be='bundle exec'
alias br='bundle exec rails'
alias bh='bundle exec hanami'
alias brs='bundle exec rails s'
alias brc='bundle exec rails c'
alias rubo="bundle exec rubocop"
alias ruboa="bundle exec rubocop -a"
alias dk='docker'
alias dkc='docker-compose'
alias dkcd="docker-compose down"
alias dkcu="docker-compose up"
alias dkcub="docker-compose up --build"
alias dkcud="docker-compose up -d"
alias dkcubd="docker-compose up --build -d"
alias dkr='docker-compose run web'
alias dkps="docker ps"

alias tenki="curl wttr.in"
alias now="date "+%H:%M:%S"&&cal"
alias aqua="asciiquarium"
alias cay="cal 2020"

alias chi="sh ~/code/chrome_history_fzf.sh -d"

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


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yuma/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yuma/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yuma/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yuma/google-cloud-sdk/completion.zsh.inc'; fi


# ==================================
## functions
# ==================================

function searchByGoogle() {
    [ -z "$1" ] && searchWord=`pbpaste` || searchWord=$1
    open https://www.google.co.jp/search\?q\=$searchWord
}

# time
functions _figlet_time() {
date=`date +%m/%d`
time=`date +%H:%M:%S`

figlet $date $time
}
alias t='_figlet_time'

# batch
function _set_badge() {
    printf "\e]1337;SetBadgeFormat=%s\a" $(/bin/echo -n "$1" | base64)
}
alias ba='_set_badge'

# docker exec -it
function _docker_compose_exec(){
  image="$1"
  docker exec -it $image bash
}
alias dkeit='_docker_compose_exec'

# mkdir then cd
function _makedir_then_changedir(){
  dir=$1
  mkdir -p $dir
  cd $dir
 }
alias mcdir='_makedir_then_changedir'

alias dri="dri"
function _get_http_status(){
  url=$1
  curl -LI $url -o /dev/null -w '%{http_code}\n' -s
}

alias curls="_get_http_status"

function _vim_git_diff_branch(){
  if [ "$1" -eq "" ]; then
    branch=master
  else
    branch="$1"
  fi

  vim -p `git diff --name-only $branch`
}
alias vimd="_vim_git_diff_branch"

function _search_by_google(){
  word="$1"
  open "https://google.com/search?q=$word"
}
alias gg="_search_by_google"
function _search_by_google(){
  word="$1"
  open "https://google.com/search?q=$word"
}
alias goo="_search_by_vim"
function _search_by_vim(){
  tmp_file=$HOME/.tmp_search
  vim $tmp_file
  word=$(cat $tmp_file)

  open "https://google.com/search?q=$word"
  rm -rf $tmp_file
}


function _dairy(){
  date=`date +%Y%m%d`
  open "https://scrapbox.io/Yumadairy/$date"
}
alias dai="_dairy"


function _edit_pbcopy(){
  file=$HOME/.tmp.txt
  touch $file
  vim $file
  tmp=$(cat $file) ; echo -n $tmp | pbcopy
  rm $file
}
alias e="_edit_pbcopy"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
