#!/bin/bash
#
# ...exists to not have ugly looking code blocks in ci lmao

# BOT_TOKEN/CHAT_ID kosong (secrets belum di-set di repo) -> skip diam-diam
# alih-alih curl ke https://api.telegram.org/bot/... yang selalu balas 404.
if [ -z "${BOT_TOKEN}" ] || [ -z "${CHAT_ID}" ]; then
  exit 0
fi

case $1 in
  msg)
    curl -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
      -d chat_id="${CHAT_ID}" \
      -d "disable_web_page_preview=true" \
      -d "parse_mode=html" \
      -d text="$(echo "$2" | sed 's/%nl/\n/g')"
  ;;
  up | upload)
    curl -F chat_id="${CHAT_ID}" \
      -F document=@"$2" \
      -F parse_mode=markdown https://api.telegram.org/bot${BOT_TOKEN}/sendDocument \
      -F caption="$(echo "$3" | sed 's/%nl/\n/g')"
  ;;
esac
