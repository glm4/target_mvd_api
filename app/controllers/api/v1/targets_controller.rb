module Api
  module V1
    class TargetsController < Api::V1::ApiController

      def index
        @targets = current_user.targets
      end

      def create
        @target = current_user.targets.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end
    end
  end
end
