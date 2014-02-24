# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/move'

describe TrelloGithub::Commands::Move do

  let(:m) { TrelloGithub::Commands::Move.new(24, '52bcd359836e999e6801ac63') }

  it 'should be initialized with the correct arguments' do
    m.card_id.should eq 24
    m.target_list.should eq '52bcd359836e999e6801ac63'
  end

  it 'should call the api wrapper methods on execute' do
    api_wrapper = double('api_wrapper', move_card: true)
    m.execute(api_wrapper)
    expect(api_wrapper).to have_received(:move_card).with(24, '52bcd359836e999e6801ac63')
  end
end
