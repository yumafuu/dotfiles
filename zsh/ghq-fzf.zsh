function ghq-fzf() {
  eval $(_ghq-fzf run)
  zle accept-line
  zle reset-prompt
}

zle -N ghq-fzf
bindkey "^o" ghq-fzf
