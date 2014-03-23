# Encoding: utf-8

require 'spec_helper'
require 'trello_github/push_event'

describe TrelloGithub::PushEvent do
  it 'should provide accessors for its data' do
    pe = new_pe(symbol_payload)
    %w(ref repo_name commits).each do |method|
      pe.should respond_to method.to_sym
    end
  end

  it 'can be populated with a string or symbol hash' do
    [string_payload, symbol_payload].each do |payload|
      pe = new_pe payload
      pe.ref.should eq 'some/ref'
      pe.repo_name.should eq 'some-repo-name'
      pe.commits.length.should eq 2
    end
  end

  it 'exposes commits as nested structs' do
    [string_payload, symbol_payload].each do |payload|
      pe = new_pe payload
      commit = pe.commits.first
      commit.id.should eq 'some_sha'
      commit.message.should eq 'some message'
      commit.author.name.should eq 'Jason'
      commit.author.email.should eq 'test@email.com'
      commit.url.should eq 'http://www.commit.com/my_commit'
      commit.distinct.should be_true
    end
  end

  it 'can generate move commands' do
    trello_command_generator = double('trello_command_generator', parse_commit: true)
    pe = new_pe symbol_payload
    pe.trello_commands(trello_command_generator)
    expect(trello_command_generator).to have_received(:parse_commit).twice
  end
end

def new_pe(payload_hash)
  TrelloGithub::PushEvent.new(payload_hash)
end
