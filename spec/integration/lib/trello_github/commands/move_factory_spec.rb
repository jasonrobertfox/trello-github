# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/move'
require 'trello_github/commands/move_factory'

describe TrelloGithub::Commands::MoveFactory do
  let(:mf) { TrelloGithub::Commands::MoveFactory.new(%w(fix)) }

  it 'should return a move command on build' do
    command = mf.build(24)
    command.should be_an_instance_of TrelloGithub::Commands::Move
  end
end
