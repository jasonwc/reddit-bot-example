module RedditBot
  class Bot < SlackRubyBot::Bot
    help do
      title 'Reddit Bot'
      desc 'Grabs posts from Reddit!'

      command 'reddit' do
        desc 'Returns back the top 3 posts for a given subreddit. `@reddit-bot reddit <subreddit>`'
      end
    end
  end
end
