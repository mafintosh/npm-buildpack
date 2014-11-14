#!/bin/bash

if [ -d node_modules ]; then
  npm rebuild
  npm run build
else
  npm install --cache-min 99999999
  npm run build
fi