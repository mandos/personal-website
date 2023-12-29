#!/usr/bin/env bash
# set -x
echo "Publishing site with Emacs..."
echo "Usage: ./scripts/publish.sh [elisp-script]"
echo "  elisp-script: the elisp script to run"

if [[ -n $1 ]]; then
  ELISP_SCRIPT=$1
else
  ELISP_SCRIPT=$(dirname "${BASH_SOURCE[0]}")/build-emacs.el
fi

emacs --batch --script "${ELISP_SCRIPT}"
