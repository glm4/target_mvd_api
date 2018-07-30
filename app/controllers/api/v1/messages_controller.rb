module Api
  module V1
    class MessagesController < Api::V1::ApiController

      def index
        @messages = current_user.matches.find(match_id).messages.includes(:user)
      end

      def create
        @message = current_user.messages.create!(message_params.merge(match_id: match_id))
      end

      private

      def message_params
        params.require(:message).permit(:content)
      end

      def match_id
        params[:match_id]
      end
    end
  end
end
