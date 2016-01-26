# Build and deploy mattermost from source to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This buildpack is an [inline buildpack](https://github.com/kr/heroku-buildpack-inline/) (tldr: this repo deploys to Heroku and uses itself as a buildpack) for deploying [Mattermost](https://mattermost.org) to [Heroku](https://heroku.com).
You could say it's a hybrid of the Node and Go buildpacks, specifically designed to set up a build environment for Mattermost, and comes with a startup script that writes your Heroku environment variables to a config file when the dyno starts up (because Mattermost is not a [12 factor app](http://12factor.net/config) .... yet)

## Rebuilding

Due to the nature of this being an inline buildpack, You have two options if you want to deploy a new version of Mattermost:

1. create an empty git commit - `git commit --allow-empty -m "empty commit"` and push it to the Heroku app repo
2. (preferred) use the [Build and Release API](https://devcenter.heroku.com/articles/build-and-release-using-the-api#creating-builds)
  * [httpie example](https://github.com/jakubroztocil/httpie): `http post https://api.heroku.com/apps/app-name/builds source_blob:='{"source_blob":{"url":"https://github.com/heroku/node-js-sample/archive/master.tar.gz", "version": "cb6999d361a0244753cf89813207ad53ad906a14"}}' Accept:"application/vnd.heroku+json; version=3" `

## Warnings

1. Don't make configuration changes in the Mattermost admin console.
   Any configuration changes in the Mattermost admin console will likely be lost on dyno restart (which may be every 24 hours) and will likely not be distributed across multiple dynos.
2. Not using s3 means any uploads will be lost on dyno restart or application reconfiguration or redeploy and won't be consistent across multiple dynos.
   Without s3 backing this is not anything more than a one time demo.

## To Do

* Add more config options
* Cache Node tarball
