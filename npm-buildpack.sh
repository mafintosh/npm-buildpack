#!/bin/bash

CACHE_ID="$1"

if [ "$CACHE_ID" == "" ] && [ -f package.json ]; then
	CACHE_ID=$(cat package.json | grep '"name"' | sed 's/"name"//; s/[^"]*"//; s/"[^"]*//')
fi

if [ "$CACHE_ID" == "" ]; then
	CACHE_ID=__misc__
fi

CACHE_DIR="/tmp/npm-buildpack/$CACHE_ID"

if [ -d node_modules ]; then
	npm rebuild
else
	mkdir -p "$CACHE_DIR"
	cp -r "$CACHE_DIR" node_modules
	npm prune > /dev/null 2> /dev/null
	npm install --production || exit $?
	rm -rf "$CACHE_DIR"
	cp -r node_modules "$CACHE_DIR"
fi