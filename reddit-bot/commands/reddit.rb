require 'net/http'

module RedditBot
  module Commands
    class Reddit < SlackRubyBot::Commands::Base
      BASE_URL = "https://www.reddit.com/r/"

      command 'reddit' do |client, data, match|
        # Grab the subreddit and sort order from the command, or choose defaults
        args = match[:expression].split(' ')
        subreddit = args.try(:[], 0) || 'all'
        sort_by = args.try(:[], 1) || 'hot'

        # Ensure we don't try to pass an invalid sort order
        sort_by = ['hot', 'controversial', 'top', 'rising', 'new'].include?(sort_by) ? sort_by : 'hot'

        client.say(channel: data.channel, text: "Grabbing #{sort_by} posts from /r/#{subreddit}...")

        # Get the data from Reddit and format as JSON
        uri = URI("https://www.reddit.com/r/#{subreddit}/#{sort_by}.json")
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
