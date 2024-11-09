function _fzf_cd_ghq() {
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
  local root="$(ghq root)"
  local list=$(ghq list)
  list+="\n../dotfiles"
  local repo="$(echo "$list" | fzf --preview="exa --tree -L 2 --color=always ${root}/{1}")"
  local dir="${root}/${repo}"
  [ -n "${dir}" ] && cd "${dir}" || exit
  zle accept-line
  zle reset-prompt
}

zle -N _fzf_cd_ghq
bindkey "^o" _fzf_cd_ghq
