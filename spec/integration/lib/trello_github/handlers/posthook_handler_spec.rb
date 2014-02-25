# Encoding: utf-8

require 'spec_helper'
require 'trello_github/handlers/posthook_handler'

describe TrelloGithub::Handlers::PosthookHandler do

  it 'should handle a github posthook payload' do
    trello_api_wrapper = double('trello_api_wrapper', move_card: true)
    config = YAML.load_file(resource('test_config.yml'))
    payload_json = payload.to_json

    handler = TrelloGithub::Handlers::PosthookHandler.new(config, trello_api_wrapper)
    handler.handle(payload_json)

    expect(trello_api_wrapper).to have_received(:move_card).with(24, 'close-list-id')

  end
end

def payload
  { 'head' => 'some_sha', 'ref' => 'some/ref', 'size' => 1, 'commits' => [commit] }
end

def commit
  {
    'sha' => 'some_sha',
    'message' => 'some thing to close 24 and win',
    'author' => { 'name' => 'Jason', 'email' => 'test@email.com' },
    'url' => 'http://www.commit.com/my_commit',
    'distinct' => true
  }
end
