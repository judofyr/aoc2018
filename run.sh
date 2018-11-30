#!/usr/bin/env bash
set -e
shopt -s nullglob

PROG="$1"

if [ -z "$PROG" ]; then
  echo "usage: $0 DAY"
  exit 1
fi

NUM="${PROG%+}"
INPUT="build/day$NUM.txt"
SESSION=$(cat build/session.txt)
YEAR=2018

if [ ! -f "$INPUT" ]; then
  curl "https://adventofcode.com/$YEAR/day/$NUM/input" -H "cookie: session=$SESSION" -o "$INPUT" -f
fi

SCRIPT="./day$PROG"

if [ ! -f "$SCRIPT" ]; then
  echo "No script for $PROG"
  exit 1
fi

"$SCRIPT" < "$INPUT"

