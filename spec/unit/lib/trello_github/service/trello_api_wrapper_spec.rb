# Encoding: utf-8

require 'spec_helper'
require 'trello_github/service/trello_api_wrapper'

describe TrelloGithub::Service::TrelloApiWrapper do
  let(:trello_api_wrapper) { TrelloGithub::Service::TrelloApiWrapper.new(trello_developer_public_key: 'abc123', trello_member_token: '123abc') }

  it 'should be initialized with a hash of auth parameters' do
    trello_api_wrapper.credentials[:trello_developer_public_key].should eq 'abc123'
    trello_api_wrapper.credentials[:trello_member_token].should eq '123abc'
  end

  it 'should respond to move_card' do
    trello_api_wrapper.should respond_to :move_card
  end

  it 'should respond to comment_on_card' do
    trello_api_wrapper.should respond_to :comment_on_card
  end
end
