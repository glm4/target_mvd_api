module Api
  module V1
    class TargetsController < Api::V1::ApiController
      helper_method :current_target

      def show
        current_target
      end

      def index
        @targets = current_user.targets.within(Target::MAX_RADIUS, origin: location_params)
      end

      def create
        @target = current_user.targets.create!(target_params)
        render :show
      end

      def destroy
        current_target.destroy
      end

      def update
        current_target.update!(target_params)
        render :show
      end

      private

      def current_target
        @target = current_user.targets.find(params[:id])
      end

      def target_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end

      def location_params
        params.require([:lat, :lng])
      end
    end
  end
end
