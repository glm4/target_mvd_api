# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :user, :match, presence: true
  validate :match_belongs_to_user, on: :create

  def match_belongs_to_user
    if !user.matches.ids.include?(match_id)
      errors[:user] << I18n.t('api.errors.match_access_forbidden')
    end
  end
end
