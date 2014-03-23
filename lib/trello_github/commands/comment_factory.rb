# Encoding: utf-8

require 'trello_github/commands/comment'

module TrelloGithub
  module Commands
    class CommentFactory
      attr_reader :verbs
      def initialize(verbs)
        @verbs = verbs
      end

      def build(card_id, commit)
        # TODO: we could use the config parameter parsing to allow the user to
        # define their own message formats
        comment = format "%s: %s\n\n%s", commit.author.name, commit.message, commit.url
        Comment.new(card_id, comment)
      end
    end
  end
end
