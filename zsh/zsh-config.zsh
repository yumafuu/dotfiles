# zstyle
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# options
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
export LESS='-R'
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export WORDCHARS='*?_.[]~-&;!#$%^(){}<>'
export GPG_TTY=$(tty)

# autoload
autoload colors

# compinit
_compinit() {
  local re_initialize=0
  for match in ${ZDOTDIR}/.zcompdump*(.Nmh+24); do
    re_initialize=1
    break
  done

  autoload -Uz compinit
  if [ "$re_initialize" -eq "1" ]; then
    compinit
    # update the timestamp on compdump file
    compdump
  else
    # omit the check for new functions since we updated today
    compinit -C
  fi
}
_compinit

# stty
stty erase '^?'

# setopt
bindkey '^A' beginning-of-line
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
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt IGNORE_EOF
setopt auto_cd
