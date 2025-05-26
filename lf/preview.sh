#!/usr/bin/env bash
# preview.sh -- lf 用プレビュー・スクリプト

FILE="$1"
HEIGHT="${LINES:-30}"
WIDTH="${COLUMNS:-80}"

# MIME タイプを取得
MIME_TYPE=$(file --mime-type -Lb "$FILE" | awk -F/ '{print $1}')

case "$MIME_TYPE" in
  image)
    # 画像は chafa でターミナルに描画
    chafa --fill=block --symbols=block --stretch --size "${WIDTH}x${HEIGHT}" "$FILE"
    ;;

  application)
    # PDF: application/pdf
    if [[ "$(file --mime-type -Lb "$FILE")" == "application/pdf" ]]; then
      # テキスト化して表示（先頭 $HEIGHT 行）
      pdftotext "$FILE" - | head -n $HEIGHT
    else
      # その他バイナリ：ファイル情報のみ
      echo "==> $(basename "$FILE") <=="
      file "$FILE"
    fi
    ;;

  text)
    # テキストファイルは bat（あれば）でシンタックスハイライト、
    # なければ cat
    if command -v bat &> /dev/null; then
      bat --style=plain --color=always --line-range=:${HEIGHT} "$FILE"
    else
      head -n $HEIGHT "$FILE"
    fi
    ;;

  video|audio)
    # 動画・音声は mediainfo でメタ情報
    if command -v mediainfo &> /dev/null; then
      mediainfo "$FILE"
    else
      echo "mediainfo コマンドが見つかりません"
    fi
    ;;

  font)
    # フォントファイルのプレビュー
    if command -v chafa &> /dev/null; then
      chafa --fill=block --symbols=block --stretch --size 10x10 "$FILE"
    else
      echo "Font file: $(basename "$FILE")"
    fi
    ;;

  *)
    # それ以外はファイル情報
    echo "==> $(basename "$FILE") <=="
    file "$FILE"
    ;;
esac

