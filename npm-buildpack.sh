#!/bin/bash

CACHE_ID="${1:__misc__}"
CACHE_DIR="/tmp/npm-install-cache/$CACHE_ID"

if [ -d node_modules ]; then
	npm rebuild
else
	mkdir -p "$CACHE_DIR"
	cp -r "$CACHE_DIR" node_modules
	npm prune --no-warn > /dev/null 2> /dev/null
	npm install --production || exit $?
	rm -rf "$CACHE_DIR"
	cp -r node_modules "$CACHE_DIR"
fi