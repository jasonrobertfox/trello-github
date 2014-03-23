require 'sinatra/base'
require 'trello_github/handlers/posthook_handler'
require 'trello_github/service/trello_api_wrapper'

class TrelloGithubServer < Sinatra::Base
  set :root, File.expand_path(File.join(Dir.pwd, 'lib'))
  config = YAML.load_file('config/config.yml')
  trello_developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
  trello_member_token =  ENV['TRELLO_MEMBER_TOKEN']

  fail ArgumentError, 'A "trello_developer_public_key" must be defined!' unless trello_developer_public_key
  fail ArgumentError, 'A "trello_member_token" must be defined!' unless trello_member_token

  trello_api_wrapper = TrelloGithub::Service::TrelloApiWrapper.new(trello_developer_public_key: trello_developer_public_key, trello_member_token: trello_member_token)

  set :handler, TrelloGithub::Handlers::PosthookHandler.new(config, trello_api_wrapper)

  post '/posthook' do
    settings.handler.handle(request.body.read)
    status 200
  end
end
