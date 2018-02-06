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

        # Get the data from Reddit and format as JSON
        uri = URI("https://www.reddit.com/r/#{subreddit}/#{sort_by}.json")
        response = JSON.parse(Net::HTTP.get(uri))

        # # Grab the first 3 posts, and get the information we care about
        posts = response['data']['children'].first(3).map do |post|
          {
            url: post['data']['url'],
            title: post['data']['title'],
            score: post['data']['score'],
            permalink: post['data']['permalink'],
            self_post: post['data']['is_self'],
            body: post['data']['self_text'],
            subreddit: post['data']['subreddit'],
            num_comments: post['data']['num_comments'],
          }
        end

        # Format the message
        message = {
          "text": "Here are the first 3 #{sort_by} posts on /r/#{subreddit}",
          "attachments": posts.map do |post|
            {
              "fallback": post[:title],
              "color": "#ff5700",
              "title": post[:title],
              "title_link": "http://www.reddit.com#{post[:permalink]}",
              "text": post[:self_post] ? post[:body] : post[:url],
              "fields": [
                {
                  "title": "Type",
                  "value": post[:self_post] ? 'Self' : 'Link',
                  "short": true
                },
                {
                  "title": "Subreddit",
                  "value": "/r/#{post[:subreddit]}",
                  "short": true
                },
                {
                  "title": "Score",
                  "value": post[:score],
                  "short": true
                },
                {
                  "title": "Comments",
                  "value": post[:num_comments],
                  "short": true
                }
              ]
            }
          end
        }

        # Message the channel with a formatted message using the web client
        client.web_client.chat_postMessage(channel: data.channel, as_user: true, **message)
      end
    end
  end
end
