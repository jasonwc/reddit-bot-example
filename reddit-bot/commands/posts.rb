require 'reddit-bot/controllers/posts_controller'
require 'reddit-bot/models/posts'
require 'reddit-bot/views/posts'

module RedditBot
  module Commands
    class Posts < SlackRubyBot::Commands::Base
      model = RedditBot::Models::Posts.new
      view = RedditBot::Views::Posts.new
      @controller = RedditBot::Controllers::PostsController.new(model, view)
    end
  end
end
