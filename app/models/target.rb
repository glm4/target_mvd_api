# == Schema Information
#
# Table name: targets
#
#  id         :integer          not null, primary key
#  title      :string
#  lat        :decimal(, )
#  lng        :decimal(, )
#  radius     :decimal(, )
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Target < ApplicationRecord
  MAX_RADIUS = ENV['TARGET_RADIUS_VISIBILITY'].to_f
  PER_USER_LIMIT = ENV['TARGET_PER_USER_LIMIT'].to_i

  belongs_to :topic
  belongs_to :user
  validates :topic, :title, :lat, :lng, :radius, presence: true
  acts_as_mappable lat_column_name: :lat,
                   lng_column_name: :lng
end
