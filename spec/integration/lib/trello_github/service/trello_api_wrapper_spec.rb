# Encoding: utf-8

require 'spec_helper'
require 'trello_github/service/trello_api_wrapper'

describe TrelloGithub::Service::TrelloApiWrapper do
  let(:trello_api_wrapper) { TrelloGithub::Service::TrelloApiWrapper.new(trello_developer_public_key: 'abc123', trello_member_token: '123abc') }

  before(:each) do
    stub_request(:get, 'https://api.trello.com/1/boards/?key=abc123&token=123abc')
    .with(headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '{"id": "board-id"}', headers: {})
    stub_request(:get, 'https://api.trello.com/1/boards/board-id/cards/12?key=abc123&token=123abc')
    .with(headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '{"id": "card-id"}', headers: {})
    stub_request(:post, 'https://api.trello.com/1/cards/card-id/actions/comments?key=abc123&token=123abc')
    .with(body: { 'text' => 'some message' },
          headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'Content-Length' => '19', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '', headers: {})
    stub_request(:put, 'https://api.trello.com/1/cards/card-id/idList?key=abc123&token=123abc')
    .with(body: { 'value' => 'move-list-id' },
          headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'Content-Length' => '18', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '', headers: {})
  end

  it 'should successfully move a card' do
    response = trello_api_wrapper.move_card(12, 'move-list-id')
    response.should eq ''
  end

  it 'should successfully comment on a card' do
    response = trello_api_wrapper.comment_on_card(12, 'some message')
    response.should eq ''
  end
end
