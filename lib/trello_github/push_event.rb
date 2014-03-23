# Encoding: utf-8
# http://developer.github.com/v3/activity/events/types/#pushevent

module TrelloGithub
  class PushEvent
    Commit = Struct.new(:id, :message, :author, :url, :distinct)
    Author = Struct.new(:name, :email)

    attr_reader :head, :ref, :repo_name, :commits

    def initialize(payload_hash)
      payload_hash = symbolize(payload_hash)
      @ref = payload_hash[:ref]
      @repo_name = payload_hash[:repository][:name]
      @commits = make_commit_objects(payload_hash[:commits])
    end

    def trello_commands(trello_command_generator)
      # TODO: Perhaps we should verify the uniqueness of a command
      @commits.map do |commit|
        trello_command_generator.parse_commit(commit)
      end.flatten
    end

    private

    def make_commit_objects(commits_array)
      if commits_array
        commits_array.map do |commit|
          author = Author.new(commit[:author][:name], commit[:author][:email])
          Commit.new(commit[:id], commit[:message], author, commit[:url], commit[:distinct])
        end
      end
    end

    def symbolize(hash)
      result = {}
      if hash.is_a? Hash
        hash.each do |key, val|
          result[key.to_sym] = symbolize(val)
        end
        return result
      elsif hash.is_a? Array
        return hash.map { |r| symbolize(r) }
      else
        return hash
      end
    end
  end
end
