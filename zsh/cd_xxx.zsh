function cd_target() {
  d=$(
    fd --type d -H \
      -E .git \
      -E node_modules \
      -E .terragrunt-cache |
      fzf --select-1 --preview 'exa -T --git-ignore {}'
  )

  if [[ $d = "" ]]; then
    return
  fi

  cd "$d" || exit
}

zle -N cd_target
bindkey "^k" cd_target

zle -N cd_parent
bindkey "^h" cd_parent
cd_parent() {
  cd ..
  zle accept-line
}

cd_back() {
  cd -
  zle accept-line
}
