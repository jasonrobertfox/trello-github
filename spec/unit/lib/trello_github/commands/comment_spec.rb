# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/comment'
require 'unit/lib/trello_github/commands/shared_examples'

describe TrelloGithub::Commands::Comment do
  let(:c) { TrelloGithub::Commands::Comment.new(24, 'Some comment') }

  it_should_behave_like 'command'

  it 'should be initialized with the correct arguments' do
    c.card_id.should eq 24
    c.comment.should eq 'Some comment'
  end

  it 'should call the api wrapper methods on execute' do
    api_wrapper = double('api_wrapper', comment_on_card: true)
    c.execute(api_wrapper)
    expect(api_wrapper).to have_received(:comment_on_card).with(24, 'Some comment')
  end
end
