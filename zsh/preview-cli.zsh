preview-cli() {
  if [ -z "$1" ]; then
    echo "Usage: preview-cli <file>"
    return 1
  fi

  # check file type using file command.
  file "$1" | grep -q "PDF document" && tdf "$1" && return
  file "$1" | grep -q "image data" && imgcat "$1" && return
  # if svg, use imgcat
  file "$1" | grep -q "SVG" && imgcat "$1" && return
  bat --style=numbers --color=always "$1"
}
