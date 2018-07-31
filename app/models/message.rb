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
  after_create :update_match_last_message

  belongs_to :user
  belongs_to :match

  validates :user, :match, presence: true
  validate :match_belongs_to_user, on: :create

  def match_belongs_to_user
    return if user.blank? || match.blank? || user.matches.include?(match)
    errors[:user] << I18n.t('api.errors.match_access_forbidden')
  end

  private

  def update_match_last_message
    match.last_message = content
    match.save!
  end
end
