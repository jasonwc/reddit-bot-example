module RedditBot
  class Bot < SlackRubyBot::Bot
    help do
      title 'Reddit Bot'
      desc 'Grabs posts from Reddit!'

      command 'reddit' do
        desc 'Returns back the top 5 posts on /r/all'
      end
    end
  end
end
