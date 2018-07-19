module Api
  module V1
    class TargetsController < Api::V1::ApiController

      def index
        @targets = current_user.targets.within(Target::MAX_RADIUS, origin: location_params)
      end

      def create
        if current_user.targets.count < Target::PER_USER_LIMIT
          @target = current_user.targets.create!(target_params)
        else
          render json: { error: I18n.t('api.errors.max_target_limit_reached') }, status: :bad_request
        end
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
