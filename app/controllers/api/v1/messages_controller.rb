module Api
  module V1
    class MessagesController < Api::V1::ApiController

      def index
        @messages = current_match.messages.includes(:user)
      end

      def create
        @message = current_user.messages.create!(message_params.merge(match: current_match))
      end

      private

      def message_params
        params.require(:message).permit(:content)
      end

      def current_match
        current_user.matches.find(params[:match_id])
      end
    end
  end
end
