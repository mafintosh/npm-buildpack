#!/bin/bash

if [ "$1" == "--help" ]; then
  echo "Usage: npm-buildpack [npm-options]"
  echo ""
  echo "  [npm-options] are passed to npm install"
  echo ""
  exit 0
fi

build () {
  grep '"build":' package.json 2>/dev/null >/dev/null && npm run build
}

if [ -d node_modules ]; then
  npm rebuild "$@"
  build
else
  npm install --cache-min 99999999 "$@"
  build
fi