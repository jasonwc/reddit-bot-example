require 'net/http'

module RedditBot
  module Commands
    class Reddit < SlackRubyBot::Commands::Base
      command 'reddit' do |client, data, _match|
        # Get the data from Reddit and format as JSON
        uri = URI('https://www.reddit.com/r/all.json')
        response = JSON.parse(Net::HTTP.get(uri))

        # Grab the first 3 posts, and get the information we care about
        posts = response['data']['children'].first(3).map do |post|
          {
            url: post['data']['url'],
            title: post['data']['title'],
            score: post['data']['score']
          }
        end

        # Message the channel for each post
        posts.each do |post|
          client.say(channel: data.channel, text: "Title: #{post[:title]}, Link: #{post[:url]}, Score: #{post[:score]}")
        end
      end
    end
  end
end
