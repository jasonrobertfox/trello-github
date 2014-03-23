# Encoding: utf-8

require 'trello'

module TrelloGithub
  module Service
    class TrelloApiWrapper
      attr_reader :credentials

      attr_accessor :board_id

      def initialize(credentials)
        @credentials = credentials
        Trello.configure do |config|
          config.developer_public_key = credentials[:trello_developer_public_key]
          config.member_token = credentials[:trello_member_token]
        end
      end

      def move_card(card_id, target_list)
        board = Trello::Board.find(@board_id)
        card = board.find_card(card_id)
        card.move_to_list(target_list)
      end

      def comment_on_card(card_id, comment)
        board = Trello::Board.find(@board_id)
        card = board.find_card(card_id)
        card.add_comment(comment)
      end
    end
  end
end
