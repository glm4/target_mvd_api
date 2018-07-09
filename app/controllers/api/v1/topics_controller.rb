# encoding: utf-8

module Api
  module V1
    class TopicsController < Api::V1::ApiController
      helper_method :topic

      # def show; end

      def index
        @topics = Topic.all
      end

      # def create
      #   @topic = Topic.create!(topic_params[:name])
      #   # @topic.icon = TopicIconUploader.new(topic_params[:icon])
      #   # @topic.icon.save!
      #   render :show
      # end

      # private
      #
      # def topic_params
      #   params.require(:topic).permit(:name, :icon)
      # end
      #
      # def topic
      #   @topic ||= topic_id.present? ? Topic.find(topic_id) : Topic.create!(topic_params)
      # end
      #
      # def topic_id
      #   params[:id]
      # end
    end
  end
end
