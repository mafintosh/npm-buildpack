# npm-buildpack

Install or build node_modules from a cache

	npm install -g npm-buildpack

## Usage

After installing go to a node app and run

	npm-buildpack my-app-id # my-app-id is $CACHE_ID

The script will do the following things

1. If there already is a node_modules folder just run `npm rebuild`
2. See if there is cache stored for `$CACHE_ID`. If so copy it to ./node_modules
3. Prune the cache
3. Run `npm install --production`
4. Save ./node_modules to the cache

Primarily useful when your are deploying / building a node app on a remote server.
This is similar to the [heroku node.js buildpack](https://github.com/heroku/heroku-buildpack-nodejs) except it only does npm stuff.

## License

MIT