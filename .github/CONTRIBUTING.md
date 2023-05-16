# Contributing

If you want to contribute to _Neat_, please [create a new issue](https://github.com/codazoda/neatcss/issues/new). Alternatively, clone the repo and send a PR.

## My Process

When I work on _Neat_ I currently do the following:

- New unreleased work goes into the `wip` branch
- Multiple commits in an unreleased branch are great
  - These will be listed in the CHANGELOG.txt file
- I can push my `wip` branch to master
- Other fixes in a `wip:<name>` branch are fine too
- A branch is released by running `release.sh`
  - This merges to main, increments the version, etc.
  - I might need to delete the branch after release to prevent all the commits?
