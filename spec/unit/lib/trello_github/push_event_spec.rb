# Encoding: utf-8
# http://developer.github.com/v3/activity/events/types/#pushevent

require 'spec_helper'
require 'trello_github/push_event'

describe TrelloGithub::PushEvent do
  it 'should provide accessors for its data' do
    pe = new_pe({})
    %w(head ref size commits).each do |method|
      pe.should respond_to method.to_sym
    end
  end

  it 'can be populated with a string or symbol hash' do
    [string_payload, symbol_payload].each do |payload|
      pe = new_pe payload
      pe.head.should eq 'some_sha'
      pe.ref.should eq 'some/ref'
      pe.size.should eq 5
      pe.commits.length.should eq 2
    end
  end

  it 'exposes commits as nested structs' do
    [string_payload, symbol_payload].each do |payload|
      pe = new_pe payload
      commit = pe.commits.first
      commit.sha.should eq 'some_sha'
      commit.message.should eq 'some message'
      commit.author.name.should eq 'Jason'
      commit.author.email.should eq 'test@email.com'
      commit.url.should eq 'http://www.commit.com/my_commit'
      commit.distinct.should be_true
    end
  end
end

def new_pe(payload_hash)
  TrelloGithub::PushEvent.new(payload_hash)
end

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
  { 'head' => 'some_sha', 'ref' => 'some/ref', 'size' => 5, 'commits' => [string_commit, string_commit]}
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
