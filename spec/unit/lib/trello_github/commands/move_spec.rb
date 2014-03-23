# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/move'
require 'unit/lib/trello_github/commands/shared_examples'

describe TrelloGithub::Commands::Move do

  let(:c) { TrelloGithub::Commands::Move.new(24, '52bcd359836e999e6801ac63') }

  it_should_behave_like 'command'

  it 'should be initialized with the correct arguments' do
    c.card_id.should eq 24
    c.target_list.should eq '52bcd359836e999e6801ac63'
  end

  it 'should call the api wrapper methods on execute' do
    api_wrapper = double('api_wrapper', move_card: true)
    c.execute(api_wrapper)
    expect(api_wrapper).to have_received(:move_card).with(24, '52bcd359836e999e6801ac63')
  end
end
