# Encoding: utf-8

require 'trello_github/commands/move'

module TrelloGithub
  module Commands
    class MoveFactory
      attr_reader :verbs
      attr_accessor :to
      def initialize(verbs)
        @verbs = verbs
      end

      def build(card_id)
        Move.new(card_id, to)
      end
    end
  end
end
