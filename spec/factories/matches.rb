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

FactoryBot.define do
  factory :match do
    last_message "MyString"
    unread_messages 1
  end
end
