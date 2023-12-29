#!/usr/bin/env bash
# set -x
echo "Building site..."
echo "Usage: ./scripts/build.sh [-s]"
echo "  -s: serve the site locally"

SERVE=""
while getopts "s" optchar; do
  case "${optchar}" in
    s)
      SERVE="true"
      ;;
    *)
      echo "Wrong parameter: ${optchar}"
      ;;
  esac
done

if [[ -n $SERVE ]]; then
  jekyll serve --source ./jekyll
else
  jekyll build --source ./jekyll
fi
