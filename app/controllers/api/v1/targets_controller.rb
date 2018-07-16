module Api
  module V1
    class TargetsController < Api::V1::ApiController

      def index
        @targets = current_user.targets.within(Target.max_radius, origin: index_params).all
      end

      def create
        @target = current_user.targets.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end

      def index_params
        params.require([:lat, :lng])
      end
    end
  end
end
