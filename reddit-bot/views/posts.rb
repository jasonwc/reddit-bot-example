module RedditBot
  module Views
    class Posts < SlackRubyBot::MVC::View::Base
      def display_posts(posts, sort_by, subreddit)
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

        client.web_client.chat_postMessage(channel: data.channel, as_user: true, **message)
      end

      def display_error(error_code)
        case error_code
          when 404
            say(channel: data.channel, text: "Oops! Looks like that subreddit doesn't exist.")
          when 403
            say(channel: data.channel, text: "Oops! Looks like that subreddit is private.")
          when 429
            say(channel: data.channel, text: "Oops! Looks like we've been rate limited. Try again later.")
          else
            say(channel: data.channel, text: "Oops! Looks like we got an unknown error. Try again!")
        end
      end

      def react_wait
        client.web_client.reactions_add(
          name: :hourglass_flowing_sand,
          channel: data.channel,
          timestamp: data.ts,
          as_user: true
        )
      end

      def react_thumbsup
        client.web_client.reactions_add(
          name: :thumbsup,
          channel: data.channel,
          timestamp: data.ts,
          as_user: true
        )
      end

      def unreact_wait
        client.web_client.reactions_remove(
          name: :hourglass_flowing_sand,
          channel: data.channel,
          timestamp: data.ts,
          as_user: true
        )
      end
    end
  end
end




