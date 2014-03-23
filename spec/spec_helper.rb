# Encoding: utf-8

require 'rspec'
require 'webmock/rspec'

ENV['RACK_ENV'] = 'test'
ENV['TRELLO_DEVELOPER_PUBLIC_KEY'] = 'abc123'
ENV['TRELLO_MEMBER_TOKEN'] = '123abc'

def configure_rspec_defaults
  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run_excluding skip: true
    config.filter_run :focus
  end
end

def configure_rspec_for_system
  require 'rack/test'
  require 'sinatra'
  require_relative '../lib/trello_github_server'

  RSpec.configure do |config|
    config.expect_with :rspec, :stdlib
    config.include Rack::Test::Methods
    def app
      TrelloGithubServer
    end
  end
end

def configure_coverage
  require 'simplecov'
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start do
    add_filter 'spec'
    coverage_dir 'build/coverage'
  end
  SimpleCov.at_exit do
    SimpleCov.result.format!
  end
end

# Configuration
configure_coverage
configure_rspec_defaults
configure_rspec_for_system
WebMock.disable_net_connect!(allow_localhost: true)

# Global Helpers
Commit = Struct.new(:sha, :message, :author, :url, :distinct)
Author = Struct.new(:name, :email)

def resource(file_name)
  File.expand_path(File.join(File.dirname(__FILE__), 'resources', file_name))
end

def symbol_payload
  { ref: 'some/ref', commits: [symbol_commit, symbol_commit], repository: { name: 'some-repo-name' } }
end

def symbol_commit(message = 'some message')
  {
    id: 'some_sha',
    message: message,
    author: { name: 'Jason', email: 'test@email.com' },
    url: 'http://www.commit.com/my_commit',
    distinct: true
  }
end

def string_payload(commits = [string_commit, string_commit])
  { 'ref' => 'some/ref', 'commits' => commits, 'repository' => { 'name' => 'some-repo-name' } }
end

def string_commit(message = 'some message')
  {
    'id' => 'some_sha',
    'message' => message,
    'author' => { 'name' => 'Jason', 'email' => 'test@email.com' },
    'url' => 'http://www.commit.com/my_commit',
    'distinct' => true
  }
end

def make_test_commit_object(message = 'some message')
  # TODO: This duplication is bad, we should pull these out of the event and
  # invoke them directly

  commit = symbol_commit(message)
  author = Author.new(commit[:author][:name], commit[:author][:email])
  Commit.new(commit[:id], commit[:message], author, commit[:url], commit[:distinct])
end
