#!/usr/bin/env bash
set -euo pipefail

HISTORY_LINES="${HISTORY_LINES:-2000}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

# ---- capture pane text ----
tmux capture-pane -p -S "-${HISTORY_LINES}" > "$tmpdir/pane.txt"

# ---- パターン定義 ----
patterns=(
  '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'
  'https?://[^\s<>"{}|\\^`\[\]]+'
  '\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b'
  '/?([a-zA-Z0-9_.-]+/)*[a-zA-Z0-9_.-]+\.[a-zA-Z0-9]{1,8}'
  '\b[0-9a-fA-F]{7,40}\b'
  '\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b'
)

# ---- マッチ抽出 ----
> "$tmpdir/matches.txt"
for pattern in "${patterns[@]}"; do
  grep -o -E "$pattern" "$tmpdir/pane.txt" 2>/dev/null || true
done | awk 'NF && length($0) > 2' | awk '!seen[$0]++' > "$tmpdir/matches.txt"

if [[ ! -s "$tmpdir/matches.txt" ]]; then
  tmux display-message "quickselect: 候補が見つかりませんでした"
  exit 0
fi

# ---- ヒント生成 ----
hints=()
for c in {a..z} {A..Z}; do hints+=("$c"); done
for c1 in {a..z}; do
  for c2 in {a..z}; do hints+=("$c1$c2"); done
done

# ---- ヒントマップ作成 ----
declare -A hint_map
hint_idx=0

while IFS= read -r match; do
  [[ $hint_idx -ge ${#hints[@]} ]] && break
  hint="${hints[$hint_idx]}"
  hint_map["$hint"]="$match"
  ((hint_idx++))
done < "$tmpdir/matches.txt"

# ---- ヒント付きテキスト生成 ----
> "$tmpdir/annotated.txt"

while IFS= read -r line; do
  line_out="$line"
  
  for hint in "${!hint_map[@]}"; do
    match="${hint_map[$hint]}"
    if [[ "$line" == *"$match"* ]]; then
      highlighted="$(printf '\033[1;33m[%s]\033[0m\033[7m%s\033[0m' "$hint" "$match")"
      line_out="${line_out/$match/$highlighted}"
    fi
  done
  
  echo -e "$line_out"
done < "$tmpdir/pane.txt" >> "$tmpdir/annotated.txt"

# ---- ヒント一覧 ----
printf '%s\n' "${!hint_map[@]}" | sort > "$tmpdir/hints.txt"

# ---- 表示と入力用のスクリプト ----
cat > "$tmpdir/input.sh" <<'INPUTSCRIPT'
#!/usr/bin/env bash
annotated="$1"
hints="$2"
output="$3"

cat "$annotated"
echo ""
printf '\033[1;32m[QuickSelect] Type hint keys (ESC/q to cancel): \033[0m'

input=""
while IFS= read -rsn1 char; do
  # ESC or q
  if [[ "$char" == $'\e' ]] || [[ "$char" == "q" ]]; then
    exit 0
  fi
  
  input+="$char"
  printf '%s' "$char"
  
  # 完全一致チェック
  if grep -Fxq "$input" "$hints"; then
    echo "$input" > "$output"
    exit 0
  fi
  
  # プレフィックスマッチチェック
  if ! grep -q "^${input}" "$hints"; then
    input=""
  fi
done
INPUTSCRIPT

chmod +x "$tmpdir/input.sh"

# ---- 実行 ----
"$tmpdir/input.sh" "$tmpdir/annotated.txt" "$tmpdir/hints.txt" "$tmpdir/selected.txt"

# ---- 選択結果を処理 ----
if [[ ! -f "$tmpdir/selected.txt" ]]; then
  exit 0
fi

selected_hint=$(cat "$tmpdir/selected.txt")
selected="${hint_map[$selected_hint]}"

# ---- クリップボードにコピー ----
if command -v pbcopy >/dev/null 2>&1; then
  printf '%s' "$selected" | pbcopy
elif command -v xclip >/dev/null 2>&1; then
  printf '%s' "$selected" | xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
  printf '%s' "$selected" | xsel -ib
elif command -v clip.exe >/dev/null 2>&1; then
  printf '%s' "$selected" | clip.exe
fi

tmux set-buffer -- "$selected" 2>/dev/null || true
tmux display-message "quickselect: copied \"$selected\""
