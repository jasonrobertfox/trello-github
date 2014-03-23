# Encoding: utf-8

require 'trello_github/trello_command_generator'
require 'trello_github/commands/move_factory'
require 'trello_github/commands/comment_factory'

module TrelloGithub
  class TrelloCommandGeneratorFactory
    def build(config)
      tcg = TrelloGithub::TrelloCommandGenerator.new
      unless config.empty?
        config['for']['rules'].each do |rule|
          verbs = rule.delete('verbs')
          rule.each_pair do |command, params|
            command_factory = build_factory(command, verbs)
            if params.is_a? Hash
              params.each_pair do |method, argument|
                command_factory.send("#{method}=", argument)
              end
            end
            tcg.register_command_factory(command_factory)
          end
        end
      end
      tcg
    end

    private

    def build_factory(command, verbs)
      # Simply a resource locater for the various factories
      case command
      when 'move'
        TrelloGithub::Commands::MoveFactory.new(verbs)
      when 'comment'
        TrelloGithub::Commands::CommentFactory.new(verbs)
      end
    end
  end
end
