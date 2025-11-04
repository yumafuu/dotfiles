#!/usr/bin/env bash
set -euo pipefail

HISTORY_LINES="${HISTORY_LINES:-2000}"   # 走査する履歴行数
MODE="${1:-any}"                         # any|url|path|email|hash
EDITOR_CMD="${EDITOR:-vim}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
pane_dump="$tmpdir/pane.txt"
candidates="$tmpdir/cands.txt"

# ---- capture pane text ----
tmux capture-pane -p -S "-${HISTORY_LINES}" > "$pane_dump"

# ---- regexes ----
re_url='https?://[^[:space:]'"'"'"]+'
re_email='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
# ゆるめのパス（拡張子付き or ディレクトリっぽい）
re_path='(~|/)?[A-Za-z0-9._-]+(/[A-Za-z0-9._-]+)*(\.[A-Za-z0-9]{1,8})?'
# 7〜40桁の(短縮)ハッシュ想定
re_hash='\b[0-9a-fA-F]{7,40}\b'

# ---- extract function (grep or rg) ----
extract() {
  local regex="$1"
  if command -v rg >/dev/null 2>&1; then
    rg -o -N --no-line-number -e "$regex" "$pane_dump" || true
  else
    grep -Eo "$regex" "$pane_dump" || true
  fi
}

case "$MODE" in
  url)   extract "$re_url"   ;;
  email) extract "$re_email" ;;
  hash)  extract "$re_hash"  ;;
  path)  extract "$re_path"  ;;
  any)
    { extract "$re_url"; extract "$re_email"; extract "$re_hash"; extract "$re_path"; } ;;
  *) echo "unknown MODE: $MODE" >&2; exit 1 ;;
esac | awk 'NF' | awk '!seen[$0]++' > "$candidates"

if [[ ! -s "$candidates" ]]; then
  tmux display-message "tmux-grab: 候補が見つかりませんでした"
  exit 0
fi

# ---- preview: 周辺文脈を表示 ----
preview_cmd='
item="{}"
if command -v rg >/dev/null 2>&1; then
  rg -n --no-heading --color=never --fixed-strings -C3 -- "$item" "'"$pane_dump"'" | sed "s/^/  /"
else
  grep -n -C3 -- "$item" "'"$pane_dump"'" | sed "s/^/  /"
fi
'

# ---- fzf 選択 ----
# Enter/Ctrl-Y: copy, Ctrl-O: open, Ctrl-E: EDITOR
selection_and_key="$(
  fzf --ansi --tac --no-sort --expect=enter,ctrl-y,ctrl-o,ctrl-e \
      --preview "$preview_cmd" < "$candidates" || true
)"

[[ -z "$selection_and_key" ]] && exit 0

pressed_key="$(printf '%s\n' "$selection_and_key" | head -n1)"
selection="$(printf '%s\n' "$selection_and_key" | sed -n '2,$p' | head -n1)"

# ---- helpers ----
copy_to_clipboard() {
  local text="$1"
  if command -v pbcopy >/dev/null 2>&1; then
    printf '%s' "$text" | pbcopy
  elif command -v xclip >/dev/null 2>&1; then
    printf '%s' "$text" | xclip -selection clipboard
  elif command -v xsel >/dev/null 2>&1; then
    printf '%s' "$text" | xsel -ib
  elif command -v clip.exe >/dev/null 2>&1; then # WSL
    printf '%s' "$text" | clip.exe
  fi
  tmux set-buffer -- "$text" || true
  tmux display-message "tmux-grab: copied"
}

open_with_system() {
  local target="$1"
  if command -v open >/dev/null 2>&1; then
    nohup open "$target" >/dev/null 2>&1 &
  elif command -v xdg-open >/dev/null 2>&1; then
    nohup xdg-open "$target" >/dev/null 2>&1 &
  else
    tmux display-message "tmux-grab: opener not found"
    return 1
  fi
  tmux display-message "tmux-grab: opened"
}

is_url()   { [[ "$1" =~ ^https?:// ]]; }
is_email() { [[ "$1" =~ ^[A-Za-z0-9._%+-]+@ ]]; }
is_hash()  { [[ "$1" =~ ^[0-9a-fA-F]{7,40}$ ]]; }

# Git ルート解決（失敗時は CWD）
git_root() {
  git rev-parse --show-toplevel 2>/dev/null || pwd
}

open_in_editor() {
  local item="$1"
  local base
  base="$(git_root)"
  # 絶対/相対に対応、存在しなければそのまま渡す
  if [[ -e "$item" ]]; then
    "$EDITOR_CMD" "$item"
  elif [[ -e "$base/$item" ]]; then
    "$EDITOR_CMD" "$base/$item"
  else
    "$EDITOR_CMD" "$item"
  fi
}

case "$pressed_key" in
  enter|ctrl-y)
    copy_to_clipboard "$selection"
    ;;
  ctrl-o)
    if is_url "$selection"; then
      open_with_system "$selection"
    elif is_email "$selection"; then
      # mailto にして開く
      open_with_system "mailto:$selection" || copy_to_clipboard "$selection"
    else
      open_with_system "$selection" || copy_to_clipboard "$selection"
    fi
    ;;
  ctrl-e)
    open_in_editor "$selection"
    ;;
  *)
    copy_to_clipboard "$selection"
    ;;
esac
