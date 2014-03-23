# Encoding: utf-8

require 'trello_github/push_event'
require 'trello_github/trello_command_generator_factory'

module TrelloGithub
  module Handlers
    class PosthookHandler
      def initialize(config, trello_api_wrapper)
        @config = config
        trello_command_generator_factory = TrelloGithub::TrelloCommandGeneratorFactory.new
        @trello_command_generator = trello_command_generator_factory.build(config)
        @trello_api_wrapper = trello_api_wrapper
      end

      def handle(payload_json)
        payload = JSON.parse(payload_json)
        event = TrelloGithub::PushEvent.new(payload)
        # TODO: This is a mess, need to clean up the way the repo name interacts
        # with the wrapper
        # i think what we may want to do is build a set of rules on app initialize then key off the
        # repo name to find the appropriate set
        # use the event to get the repo name
        # get the board id for the repo name
        @trello_api_wrapper.board_id = @config['for'][event.repo_name]

        # TODO: also need to think about parsing multiple repo board relationships

        commands = event.trello_commands(@trello_command_generator)
        commands.each do |command|
          command.execute(@trello_api_wrapper)
        end
      end
    end
  end
end
