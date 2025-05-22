#!/bin/bash
set -e

# Execute all scripts in docker-entrypoint.d
for f in /docker-entrypoint.d/*; do
  case "$f" in
    *.sh)
      echo "$0: running $f"
      "$f"
      ;;
  esac
done

# Run the original entrypoint with the provided arguments
exec /docker-entrypoint.sh "$@"
