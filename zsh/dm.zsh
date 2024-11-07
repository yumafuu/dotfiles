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
bindkey -M vicmd "^O" dm
