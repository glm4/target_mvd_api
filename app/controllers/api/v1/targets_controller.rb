module Api
  module V1
    class TargetsController < Api::V1::ApiController

      def index
        @targets = current_user.targets.within(Target::MAX_RADIUS, origin: location_params)
      end

      def create
        @target = current_user.targets.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end

      def location_params
        params.require([:lat, :lng])
      end
    end
  end
end
