# Encoding: utf-8

require 'spec_helper'
require 'trello_github/handlers/posthook_handler'

describe TrelloGithub::Handlers::PosthookHandler do

  let(:trello_api_wrapper) { double('trello_api_wrapper', move_card: true, comment_on_card: true) }
  let(:config) { YAML.load_file(resource('test_config.yml')) }
  let(:handler) { TrelloGithub::Handlers::PosthookHandler.new(config, trello_api_wrapper) }

  it 'should handle a github posthook payload' do
    payload_json = string_payload([string_commit('some thing to close 24 and fix 15')]).to_json
    handler.handle(payload_json)
    expect(trello_api_wrapper).to have_received(:move_card).twice
    expect(trello_api_wrapper).to have_received(:move_card).with(24, 'close-list-id')
    expect(trello_api_wrapper).to have_received(:move_card).with(15, 'fix-list-id')

  end

  # TODO: This is the next one that we can do comments
  # it 'should handle a github posthook payload for simple comment' do
  #   payload_json = string_payload([string_commit('some thing for card 16')]).to_json
  #   handler.handle(payload_json)
  #   expect(trello_api_wrapper).to have_received(:comment_on_card).with(16, "Jason: some thing for card 16\n\nhttp://www.commit.com/my_commit")
  # end
end
