#!/bin/sh

set -e

if [ -n "$PT_dehydrated_bin" ]; then
  dehydrated=$PT_dehydrated_bin
elif dehydrated=$(command -v dehydrated 2>/dev/null) && [ -n "$dehydrated" ]; then
  :
elif [ -x /home/dehydrated/dehydrated ]; then
  dehydrated=/home/dehydrated/dehydrated
else
  echo "dehydrated(1) was not found on the system" >&2
  exit 1
fi

"$dehydrated" --accept-terms --cron
