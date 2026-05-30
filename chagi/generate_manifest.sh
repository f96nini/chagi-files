#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
results_dir="$script_dir/results"
output_file="$script_dir/manifest.json"

if [[ ! -d "$results_dir" ]]; then
  echo "Missing results directory: $results_dir" >&2
  exit 1
fi

tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

find "$results_dir" -maxdepth 1 -type f -name '*.txt' -printf '%f\n' \
  | LC_ALL=C sort \
  | while IFS= read -r filename; do
      hash="$(sha256sum "$results_dir/$filename" | awk '{print $1}')"
      printf '%s\t%s\n' "$filename" "$hash"
    done > "$tmp_file"

version_date="$(date +%F)"
updated_utc="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

{
  printf '{\n'
  printf '  "version": "%s",\n' "$version_date"
  printf '  "updated": "%s",\n' "$updated_utc"
  printf '  "files": [\n'

  first=1
  while IFS=$'\t' read -r filename hash; do
    [[ -n "$filename" ]] || continue

    if [[ $first -eq 0 ]]; then
      printf ',\n'
    fi
    first=0

    printf '    {\n'
    printf '      "path": "results/%s",\n' "$filename"
    printf '      "sha256": "%s"\n' "$hash"
    printf '    }'
  done < "$tmp_file"

  printf '\n'
  printf '  ]\n'
  printf '}\n'
} > "$output_file"
