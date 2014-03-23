# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/comment_factory'
require 'unit/lib/trello_github/commands/shared_examples'

describe TrelloGithub::Commands::CommentFactory do
  let(:verbs) { %w(fix fixes closed) }
  let(:cf) { TrelloGithub::Commands::CommentFactory.new(verbs) }

  it_should_behave_like 'command_factory'
end
