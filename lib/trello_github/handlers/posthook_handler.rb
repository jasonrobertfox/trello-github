# Encoding: utf-8

require 'trello_github/push_event'
require 'trello_github/trello_command_generator_factory'

module TrelloGithub
  module Handlers
    class PosthookHandler
      def initialize(config, trello_api_wrapper)
        trello_command_generator_factory = TrelloGithub::TrelloCommandGeneratorFactory.new
        @trello_command_generator = trello_command_generator_factory.build(config)
        @trello_api_wrapper = trello_api_wrapper
      end

      def handle(payload_json)
        payload = JSON.parse(payload_json)
        event = TrelloGithub::PushEvent.new(payload)

        # TODO: need to adjust the hook data to be inline with https://developer.github.com/v3/activity/events/
        # use the event to get the repo name
        # get the board id for the repo name
        # TODO: also need to think about parsing multiple repo board relationships

        commands = event.trello_commands(@trello_command_generator)
        commands.each do |command|
          command.execute(@trello_api_wrapper)
        end
      end
    end
  end
end
