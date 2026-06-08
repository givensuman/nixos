#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$HOME/world/dots"
OUTPUT_DIR="$HOME/backups"
NAME_PREFIX="configs_backup"

if [[ ! -d "$SOURCE_DIR" ]]; then
	echo "missing $SOURCE_DIR folder"
	exit 1
fi

if ! command -v tar >/dev/null 2>&1; then
	echo "missing tar needed for archival"
	exit 1
fi

timestamp="$(date +%Y%m%d-%H%M%S)"
archive="$OUTPUT_DIR/${NAME_PREFIX}-${timestamp}.tar.gz"

mkdir -p "$OUTPUT_DIR"
tar -C "$SOURCE_DIR" -czf "$archive" .

printf 'backup created -> %s\n' "$archive"
