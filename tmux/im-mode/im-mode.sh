#!/bin/bash

IM_SELECT="/opt/homebrew/bin/im-select"

ime=$($IM_SELECT)

case "$ime" in
  "com.apple.keylayout.ABC")
    echo "ABC"
    ;;
  "com.google.inputmethod.Japanese.base")
    echo "あ"
    ;;
  "com.apple.inputmethod.Kotoeri.Japanese")
    echo "あ"
    ;;
  "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese")
    echo "あ"
    ;;
  *)
    echo "?"
    ;;
esac
