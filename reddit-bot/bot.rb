module RedditBot
  class Bot < SlackRubyBot::Bot
    help do
      title 'Your Bots Name'
      desc 'This is where you would put documentation about your bot'

      command 'command' do
        desc 'This is where you would put documentation about your command!'
      end
    end
  end
end
