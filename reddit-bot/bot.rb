module RedditBot
  class Bot < SlackRubyBot::Bot
    help do
      title 'Reddit Bot'
      desc 'Grabs posts from Reddit!'

      command 'reddit' do
        desc 'Returns back 3 sorted posts for a given subreddit. `@reddit-bot reddit <subreddit> <top|new|controversial|rising|hot>`'
      end
    end
  end
end
