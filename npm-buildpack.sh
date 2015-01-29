#!/bin/bash

if [ "$1" == "--help" ]; then
  echo "Usage: npm-buildpack [npm-options]"
  echo ""
  echo "  [npm-options] are passed to npm install"
  echo ""
  exit 0
fi

if [ -d node_modules ]; then
  npm rebuild "$@" || exit $?
else
  npm install --cache-min 99999999 "$@" || npm install "$@" || exit $?
fi

if grep '"build":' package.json 2>/dev/null >/dev/null; then
  npm run build
fi