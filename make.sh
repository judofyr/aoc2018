#!/usr/bin/env bash
set -e

PROG="$1"

if [ -z "$PROG" ]; then
  echo "usage: $0 day"
  exit 1
fi

FILENAME="day$PROG"

if [ -e "$FILENAME" ]; then
  echo "$FILENAME already exists"
  exit 1
fi

cat <<EOF > "$FILENAME"
#!/usr/bin/env bash
EOF

chmod +x "$FILENAME"

