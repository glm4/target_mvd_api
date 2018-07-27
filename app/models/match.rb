# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  last_message       :string
#  unread_messages    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  original_target_id :integer          not null
#  matching_target_id :integer          not null
#

class Match < ApplicationRecord

  belongs_to :original_target, class_name: :Target
  belongs_to :matching_target, class_name: :Target
  has_one :user_a, class_name: :User, through: :original_target, source: :user
  has_one :user_b, class_name: :User, through: :matching_target, source: :user

  validates :original_target, :matching_target, presence: true
end
