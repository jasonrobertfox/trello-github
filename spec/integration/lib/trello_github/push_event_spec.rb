# Encoding: utf-8

require 'spec_helper'
require 'trello_github/push_event'
require 'trello_github/commands/move'
require 'trello_github/commands/move_factory'
require 'trello_github/trello_command_generator'

describe TrelloGithub::PushEvent do
  it 'should return a move command' do
    move_factory = TrelloGithub::Commands::MoveFactory.new(%w(close))
    move_factory.to = 'abc123'
    tcg = TrelloGithub::TrelloCommandGenerator.new
    tcg.register_command_factory(move_factory)

    pe = TrelloGithub::PushEvent.new(payload)
    commands = pe.trello_commands(tcg)

    command = commands.first
    command.should be_an_instance_of TrelloGithub::Commands::Move
    command.card_id.should eq 24
    command.target_list.should eq 'abc123'
  end
end

def payload
  { 'head' => 'some_sha', 'ref' => 'some/ref', 'size' => 1, 'commits' => [commit] }
end

def commit
  {
    'sha' => 'some_sha',
    'message' => 'some thing to close 24 and win',
    'author' => { 'name' => 'Jason', 'email' => 'test@email.com' },
    'url' => 'http://www.commit.com/my_commit',
    'distinct' => true
  }
end
