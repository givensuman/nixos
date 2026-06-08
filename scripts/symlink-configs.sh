#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$HOME/world/config"
TARGET_DIR="$HOME/.config"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "missing $SOURCE_DIR folder"
	exit 1
fi

mkdir -p "$TARGET_DIR"

shopt -s nullglob
entries=("$SOURCE_DIR"/*)
shopt -u nullglob

if [[ ${#entries[@]} -eq 0 ]]; then
  echo "$SOURCE_DIR is empty, nothing to link"
	exit 0
fi

for cfg in "${entries[@]}"; do
	name="$(basename "$cfg")"
  if [[ $name == *.bak ]]; then
    continue
  fi

	dst="$TARGET_DIR/$name"

	rm -rf "$dst" &>/dev/null
	ln -s "$cfg" "$dst" &>/dev/null
	printf 'linked %s -> %s\n' "$dst" "$cfg"
done
