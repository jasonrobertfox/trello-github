# Encoding: utf-8

require 'spec_helper'
require 'trello_github/trello/api_wrapper'

describe TrelloGithub::Trello::ApiWrapper do
  let(:trello_api_wrapper) { TrelloGithub::Trello::ApiWrapper.new }
  it 'should respond to move_card' do
    trello_api_wrapper.should respond_to :move_card
  end

  it 'should respond to comment_on_card' do
    trello_api_wrapper.should respond_to :comment_on_card
  end
end
