#Trello-github Documentation

[![Code Climate](https://codeclimate.com/github/jasonrobertfox/trello-github.png)](https://codeclimate.com/github/jasonrobertfox/trello-github) [![Build Status](https://travis-ci.org/jasonrobertfox/trello-github.svg?branch=develop)](https://travis-ci.org/jasonrobertfox/trello-github) [![Coverage Status](https://coveralls.io/repos/jasonrobertfox/trello-github/badge.png?branch=develop)](https://coveralls.io/r/jasonrobertfox/trello-github?branch=develop)

###Development

    bundle exec guard

This will start guard watching and running the tests on change.

###Testing

- `rake` - Runs all of the tests.
- `rake build` - Runs a subset of build tests, as specified in the Rakefile.
- `rake quality` - Analysis of code quality with Rubocop.

###Installation

- clone this repository
- edit the `config.yml` file to support your repo, board and actions
- create a heroku application
- get your client key and secret
- use the key to create a token for write privileges
- set the two environment variables to your trello credentials https://trello.com/docs/gettingstarted/index.html#getting-an-application-key
- commit and push to your heroku app
- add a post hook to git hub


###Example

"Update docs to close 2."
