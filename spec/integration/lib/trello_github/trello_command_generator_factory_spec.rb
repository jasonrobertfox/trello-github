# Encoding: utf-8

require 'spec_helper'
require 'trello_github/trello_command_generator_factory'

describe TrelloGithub::TrelloCommandGeneratorFactory do

  it 'should have no registered command factories for a blank config' do
    tcgf = TrelloGithub::TrelloCommandGeneratorFactory.new
    tcg = tcgf.build({})
    tcg.command_factories.should be_empty
  end

  it 'should register command factories based on a config file' do
    config = YAML.load_file(resource('test_config.yml'))
    tcgf = TrelloGithub::TrelloCommandGeneratorFactory.new
    tcg = tcgf.build(config)
    tcg.command_factories.length.should eq 4
    tcg.command_factories[1].to.should eq 'close-list-id'
    tcg.command_factories[3].to.should eq 'fix-list-id'
  end
end
