# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  last_message       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  original_target_id :integer          not null
#  matching_target_id :integer          not null
#  user_a_last_online :datetime         default(Tue, 31 Jul 2018 14:25:06 UTC +00:00), not null
#  user_b_last_online :datetime         default(Tue, 31 Jul 2018 14:25:06 UTC +00:00), not null
#

class Match < ApplicationRecord
  belongs_to :original_target, class_name: :Target
  belongs_to :matching_target, class_name: :Target
  has_one :user_a, class_name: :User, through: :original_target, source: :user
  has_one :user_b, class_name: :User, through: :matching_target, source: :user
  has_many :messages, dependent: :destroy

  validates :original_target, :matching_target, presence: true

  def unread_messages(current_user_id)
    user_last_online = current_user_id == original_target.user_id ? user_a_last_online : user_b_last_online
    messages.where("created_at > ? AND user_id != ?", user_last_online, current_user_id).count
  end
end
