#!/bin/bash

run () {
	[ "${ARGS[0]}" != "run" ] && return 0
	npm "${ARGS[@]}"
}

prune () {
	# workaround for npm prune not working with bundled-deps
	for mod in $(ls node_modules); do
		[ -d "node_modules/$mod/node_modules" ] && mv "node_modules/$mod/node_modules" "node_modules/$mod/node_modules.bak"
	done
	npm prune > /dev/null 2> /dev/null
	for mod in $(ls node_modules); do
		[ -d "node_modules/$mod/node_modules.bak" ] && mv "node_modules/$mod/node_modules.bak" "node_modules/$mod/node_modules"
	done
}

ARGS=("$@")
CACHE_ID=$(cat package.json | grep '"name"' | sed 's/"name"//; s/[^"]*"//; s/"[^"]*//')

if [ "$CACHE_ID" == "" ]; then
	CACHE_ID=__misc__
fi

CACHE_DIR="/tmp/npm-buildpack/$CACHE_ID"

if [ -d node_modules ]; then
	npm rebuild
	run
else
	mkdir -p "$CACHE_DIR"
	cp -r "$CACHE_DIR" node_modules
	prune
	npm install --cache-min 999999999 || npm install || exit $?
	rm -rf "$CACHE_DIR"
	cp -r node_modules "$CACHE_DIR"
	run || exit $?
fi
