#!/bin/sh

set -e

if [ -x /home/dehydrated/dehydrated ]; then
  dehydrated=/home/dehydrated/dehydrated
elif [ -x /usr/local/bin/dehydrated ]; then
  dehydrated=/usr/local/bin/dehydrated
else
  echo "dehydrated(1) was not found on the system" >&2
  exit 1
fi

"$dehydrated" -c
