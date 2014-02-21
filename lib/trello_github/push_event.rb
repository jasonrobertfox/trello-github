# Encoding: utf-8

module TrelloGithub
  class PushEvent

    Commit = Struct.new(:sha, :message, :author, :url, :distinct)
    Author = Struct.new(:name, :email)

    attr_reader :head, :ref, :size, :commits

    def initialize(payload_hash)
      payload_hash = symbolize(payload_hash)
      @head = payload_hash[:head]
      @ref = payload_hash[:ref]
      @size = payload_hash[:size]
      @commits = make_commit_objects(payload_hash[:commits])
    end

    private

    def make_commit_objects(commits_array)
      if commits_array
        commits_array.map do |commit|
          author = Author.new(commit[:author][:name], commit[:author][:email])
          Commit.new(commit[:sha], commit[:message], author, commit[:url], commit[:distinct])
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
