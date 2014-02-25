# Encoding: utf-8

require 'spec_helper'
require 'trello_github/trello_command_generator'

describe TrelloGithub::TrelloCommandGenerator do

  let(:tcg) { TrelloGithub::TrelloCommandGenerator.new }

  it 'should allow a command factory to be registered' do
    command_factory = mock_command_factory
    tcg.register_command_factory(command_factory)
    tcg.command_factories.length.should eq 1
  end

  it 'should return no commands without registered factories' do
    tcg.parse_commit('', '', '', '', '').should be_empty
  end

  it 'should generate a command for a single card' do
    command_factory = mock_command_factory %w(fix)
    tcg.register_command_factory(command_factory)
    validate_parse('did a thing to fix 24')
    validate_built(command_factory, [24])
  end

  it 'should not generate a command if the verb is not in the message' do
    command_factory = mock_command_factory %w(fix start closes)
    tcg.register_command_factory(command_factory)
    tcg.parse_commit('did a thing to stops 24 for good', '', '', '', '')
    expect(command_factory).to have_received(:verbs)
    expect(command_factory).to_not have_received(:build).with(24)
  end

  it 'should generate a command given multiple verbs' do
    command_factory = mock_command_factory %w(fix start closes)
    tcg.register_command_factory(command_factory)
    validate_parse('did a thing that closes 24 for good')
    validate_built(command_factory, [24])
  end

  it 'should generate multiple commands given multiple verbs and the same factory' do
    command_factory = mock_command_factory %w(fix fixes closes)
    tcg.register_command_factory(command_factory)
    validate_parse('did a thing that closes 24 for good and fixes 18', 2)
    validate_built(command_factory, [24, 18])
  end

  it 'should generate multiple commands given multiple command factories' do
    fix_factory = mock_command_factory %w(fix fixes)
    tcg.register_command_factory(fix_factory)

    close_factory = mock_command_factory %w(close closes)
    tcg.register_command_factory(close_factory)

    validate_parse('did a thing that closes 24 for good and fixes 18', 2)
    validate_built(close_factory, [24])
    validate_built(fix_factory, [18])
  end
end

def mock_command_factory(verbs = [], name = 'command_factory')
  factory = double(name, build: true)
  allow(factory).to receive(:verbs).and_return(verbs)
  allow(factory).to receive(:build).and_return('command_stub')
  factory
end

def validate_built(command_factory, card_numbers)
  expect(command_factory).to have_received(:verbs)
  card_numbers.each do |card|
    expect(command_factory).to have_received(:build).with(card)
  end
end

def validate_parse(message, total = 1)
  commands = tcg.parse_commit(message, '', '', '', '')
  commands.length.should eq total
  commands.each { |command| command.should eq 'command_stub' }
end
