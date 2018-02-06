require 'net/http'

module RedditBot
  module Models
    class Posts < SlackRubyBot::MVC::Model::Base
      BASE_URL = "https://www.reddit.com/r/"

      def fetch_posts_for(subreddit, sort_by)
        uri = URI("https://www.reddit.com/r/#{subreddit}/#{sort_by}.json")
        JSON.parse(Net::HTTP.get(uri))
      end

      def posts_from_response(response)
        response['data']['children'].first(3).map do |post|
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
      end
    end
  end
end
