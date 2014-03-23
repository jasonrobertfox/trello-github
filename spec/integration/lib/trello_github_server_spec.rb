require 'spec_helper'

describe 'posthook' do

  before(:each) do
    ENV['TRELLO_DEVELOPER_PUBLIC_KEY'] = 'key'
    ENV['TRELLO_MEMBER_TOKEN'] = 'token'

    stub_request(:get, 'https://api.trello.com/1/boards/52bcd359836e999e6801ac61?key=abc123&token=123abc')
    .with(headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '{ "id": "52bcd359836e999e6801ac61" }', headers: {})
    stub_request(:get, 'https://api.trello.com/1/boards/52bcd359836e999e6801ac61/cards/16?key=abc123&token=123abc')
    .with(headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '{ "id": "card-id" }', headers: {})
    stub_request(:post, 'https://api.trello.com/1/cards/card-id/actions/comments?key=abc123&token=123abc')
    .with(body: { 'text' => "Jason Fox: Add tests for handler card 16 and wrapper.\n\nhttps://github.com/jasonrobertfox/trello-github/commit/d16ecb3e977b0090d463b195d2584f3298fb67c7" },
          headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'Content-Length' => '193', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '', headers: {})

    stub_request(:get, 'https://api.trello.com/1/boards/52bcd359836e999e6801ac61/cards/17?key=abc123&token=123abc')
    .with(headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '{ "id": "card-id" }', headers: {})

    stub_request(:put, 'https://api.trello.com/1/cards/card-id/idList?key=abc123&token=123abc')
    .with(body: { 'value' => '52bcd359836e999e6801ac64' },
          headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'Content-Length' => '30', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '', headers: {})

    stub_request(:post, 'https://api.trello.com/1/cards/card-id/actions/comments?key=abc123&token=123abc')
    .with(body: { 'text' => "Jason Fox: Add webmock, update closes 17 trello service.\n\nhttps://github.com/jasonrobertfox/trello-github/commit/f123ed1ced667c1fd0c4c3220d32755a1f89e100" },
          headers: { 'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'Content-Length' => '196', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Ruby' })
    .to_return(status: 200, body: '', headers: {})
  end

  it 'should process a github posthook' do
    post('/posthook', File.read(resource('example_push_event.json')), 'CONTENT_TYPE' => 'application/json')
    expect(last_response.status).to eq 200
  end
end
