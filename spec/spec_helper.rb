# Encoding: utf-8

require 'rspec'

def configure_rspec_defaults
  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run_excluding skip: true
    config.filter_run :focus
    config.order = 'random'
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

# Global Helpers
def symbol_payload
  { head: 'some_sha', ref: 'some/ref', size: 5, commits: [symbol_commit, symbol_commit] }
end

def symbol_commit
  {
    sha: 'some_sha',
    message: 'some message',
    author: { name: 'Jason', email: 'test@email.com' },
    url: 'http://www.commit.com/my_commit',
    distinct: true
  }
end

def string_payload
  { 'head' => 'some_sha', 'ref' => 'some/ref', 'size' => 5, 'commits' => [string_commit, string_commit] }
end

def string_commit
  {
    'sha' => 'some_sha',
    'message' => 'some message',
    'author' => { 'name' => 'Jason', 'email' => 'test@email.com' },
    'url' => 'http://www.commit.com/my_commit',
    'distinct' => true
  }
end
