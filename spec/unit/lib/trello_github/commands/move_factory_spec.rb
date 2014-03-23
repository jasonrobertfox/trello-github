# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/move_factory'
require 'unit/lib/trello_github/commands/shared_examples'

describe TrelloGithub::Commands::MoveFactory do

  let(:verbs) { %w(fix fixes closed) }
  let(:cf) { TrelloGithub::Commands::MoveFactory.new(verbs) }

  it_should_behave_like 'command_factory'

  it 'can set the "to" attribute' do
    cf.to = '52bcd359836e999e6801ac63'
    cf.to.should eq '52bcd359836e999e6801ac63'
  end

end
