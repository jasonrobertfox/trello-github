# Encoding: utf-8

require 'spec_helper'
require 'trello_github/commands/move_factory'

describe TrelloGithub::Commands::MoveFactory do

  let(:verbs) { %w(fix fixes closed) }
  let(:mf) { TrelloGithub::Commands::MoveFactory.new(verbs) }

  it 'should be initialized with a list of verbs' do
    mf.verbs.should eq verbs
  end

  it 'can set the "to" attribute' do
    mf.to = '52bcd359836e999e6801ac63'
    mf.to.should eq '52bcd359836e999e6801ac63'
  end

  it 'should respond to build' do
    mf.should respond_to :build
  end
end
