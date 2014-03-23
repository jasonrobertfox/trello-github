# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/comment'
require 'trello_github/commands/comment_factory'

describe TrelloGithub::Commands::CommentFactory do
  let(:cf) { TrelloGithub::Commands::CommentFactory.new(%w(fix)) }

  it 'should return a comment command on build' do
    command = cf.build(16, make_test_commit_object('some thing for card 16'))
    command.should be_an_instance_of TrelloGithub::Commands::Comment
    command.comment.should eq "Jason: some thing for card 16\n\nhttp://www.commit.com/my_commit"
  end
end
