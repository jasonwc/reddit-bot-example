module RedditBot
  module Controllers
    class PostsController < SlackRubyBot::MVC::Controller::Base
      define_callbacks :react, :notify
      set_callback :react, :around, :around_reaction

      def reddit
        args = match[:expression].split(' ')
        subreddit = args.try(:[], 0) || 'all'
        sort_by = args.try(:[], 1) || 'hot'

        sort_by =  valid_sort_order?(sort_by) ? sort_by : 'hot'

        run_callbacks :react do
          response = model.fetch_posts_for(subreddit, sort_by)

          if response['error'].present?
            view.display_error(response['error'])
          else
            view.display_posts(
              model.posts_from_response(response),
              sort_by,
              subreddit
            )
          end
        end
      end

      private

      def valid_sort_order?(sort_by)
        ['hot', 'controversial', 'top', 'rising', 'new'].include?(sort_by)
      end

      def around_reaction
        view.react_wait
        yield
        view.unreact_wait
        view.react_thumbsup
      end
    end
  end
end
