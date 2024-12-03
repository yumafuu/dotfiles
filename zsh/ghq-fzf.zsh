function _fzf_cd_ghq() {
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
  local ghqroot="$(ghq root)"
  local ghqlist=$(ghq list)

  IFS=$'\n'
  local list=("${(@f)$(ghq list)}")
  # add [ghq] previx to list
  for s in $ghqlist; do
    echo $s
    echo ==========
    list+="[ghq] $s\n"
  done


  list+="\n[custom] $HOME/Downloads"
  list+="\n[custom] $HOME/dotfiles"

  local repo="$(echo "$list" | fzf --preview="exa --tree -L 2 --color=always ${root}/{1}")"
  local dir="${root}/${repo}"
  [ -n "${dir}" ] && cd "${dir}" || exit
  zle accept-line
  zle reset-prompt
}

zle -N _fzf_cd_ghq
bindkey "^o" _fzf_cd_ghq
