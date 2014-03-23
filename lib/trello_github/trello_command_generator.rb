# Encoding: utf-8

module TrelloGithub
  class TrelloCommandGenerator
    attr_reader :command_factories

    def initialize
      @command_factories = []
    end

    def register_command_factory(command_factory)
      # TODO: perhaps we should verify the uniqueness of a command factory
      @command_factories << command_factory
    end

    def parse_commit(commit)
      commands = []
      @command_factories.each do |command_factory|
        verb_string = command_factory.verbs.join('|')
        matches = commit.message.scan(/(?:#{verb_string})\s+?(\d+)/).flatten
        matches.each do |match|
          commands << command_factory.build(Integer(match), commit)
        end
      end
      commands
    end
  end
end
