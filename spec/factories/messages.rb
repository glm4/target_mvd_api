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

FactoryBot.define do
  factory :message do
    content { Faker::Hacker.say_something_smart }
    match
    user { match.original_target.user }
  end
end
