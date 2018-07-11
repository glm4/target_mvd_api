module Api
  module V1
    class TargetsController < Api::V1::ApiController

      def index
        @targets = Target.all
      end

      def create
        @target = Target.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end
    end
  end
end
