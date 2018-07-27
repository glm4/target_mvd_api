module Api
  module V1
    class MatchesController < Api::V1::ApiController

      def index
        @matches = current_user.matches.includes(:original_target, :matching_target)
      end
    end
  end
end
