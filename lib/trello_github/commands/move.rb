# Encoding: utf-8

module TrelloGithub
  module Commands
    class Move
      attr_reader :card_id, :target_list
      def initialize(card_id, target_list)
        @card_id, @target_list = card_id, target_list
      end

      def execute(trello_api_wrapper)
        trello_api_wrapper.move_card(card_id, target_list)
      end
    end
  end
end
