# Encoding: utf-8

module TrelloGithub
  module Commands
    class Comment
      attr_reader :card_id, :comment
      def initialize(card_id, comment)
        @card_id, @comment = card_id, comment
      end

      def execute(trello_api_wrapper)
        trello_api_wrapper.comment_on_card(card_id, comment)
      end
    end
  end
end
