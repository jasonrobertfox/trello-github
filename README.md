#Trello-github Documentation

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

