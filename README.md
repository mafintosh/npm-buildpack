# npm-buildpack

Install or build node_modules from a cache

	npm install -g npm-buildpack

## Usage

After installing go to a node app and run

	npm-buildpack

The script will do the following things

1. If there already is a node_modules folder just run `npm rebuild`
2. See if there is cache stored for `package.name`.
3. If so prune the cache by fetching the npm changes feed
3. Run `npm install` in the cache
4. Copy the cache to ./node_modules

Primarily useful when your are deploying / building a node app on a remote server.
This is similar to the [heroku node.js buildpack](https://github.com/heroku/heroku-buildpack-nodejs) except it only does npm stuff.

## License

MIT
