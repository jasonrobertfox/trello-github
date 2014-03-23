# Encoding: utf-8

require 'spec_helper'
require 'trello_github/service/trello_api_wrapper'

describe TrelloGithub::Service::TrelloApiWrapper do
  let(:trello_api_wrapper) { TrelloGithub::Service::TrelloApiWrapper.new(trello_developer_public_key: 'abc123', trello_member_token: '123abc') }

  it 'should successfully move a card' do
    trello_api_wrapper.move_card(12, 'move-list-id')
  end

  it 'should successfully comment on a card' do
    trello_api_wrapper.move_card(12, 'some message')
  end
end
