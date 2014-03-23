# Encoding: utf-8

require 'spec_helper'
require 'trello_github/trello_command_generator'
require 'trello_github/commands/move_factory'
require 'trello_github/commands/comment_factory'

describe TrelloGithub::TrelloCommandGenerator do
  it 'should return a move command' do
    move_factory = TrelloGithub::Commands::MoveFactory.new(%w(close))
    move_factory.to = 'abc123'
    tcg = TrelloGithub::TrelloCommandGenerator.new
    tcg.register_command_factory(move_factory)
    commands = tcg.parse_commit(make_test_commit_object('do this to close 24 and win'))
    command = commands.first
    command.should be_an_instance_of TrelloGithub::Commands::Move
    command.card_id.should eq 24
    command.target_list.should eq 'abc123'
  end

  it 'should return a comment command' do
    comment_factory = TrelloGithub::Commands::CommentFactory.new(%w(card))
    tcg = TrelloGithub::TrelloCommandGenerator.new
    tcg.register_command_factory(comment_factory)
    commands = tcg.parse_commit(make_test_commit_object('do this to card 24 and win'))
    command = commands.first
    command.should be_an_instance_of TrelloGithub::Commands::Comment
    command.card_id.should eq 24
  end
end
