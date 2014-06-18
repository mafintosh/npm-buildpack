# npm-buildpack

Install or build node_modules from a cache

```
npm install -g npm-buildpack
```

## Usage

After installing go to a node app and run

```
npm-buildpack
```

The script will do the following things

1. If there already is a node_modules folder just run `npm rebuild`
2. If not is will do an `npm install` using a local cache

It handles modules cache invalidation by listening to the npm changes feed.
This ensures that you always get the most up-to-date modules according to your semvers.

Primarily useful when your are deploying / building a node app on a remote server.
This is similar to the [heroku node.js buildpack](https://github.com/heroku/heroku-buildpack-nodejs) except it only does npm stuff.

To view all available options run

```
npm-buildpack --help
```

## License

MIT
