module RedditBot
  module Commands
    class Reddit < SlackRubyBot::Commands::Base
      command 'command' do |client, data, _match|
        client.say(channel: data.channel, text: 'Fill in your own response here!')
      end
    end
  end
end
