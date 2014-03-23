#!/usr/bin/env ruby
$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
require 'trello_github_server'

use Rack::ShowExceptions
run TrelloGithubServer
