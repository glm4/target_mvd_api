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
    last_message { Faker::Hacker.say_something_smart }
    unread_messages { Faker::Number.number(1) }
    association :original_target, factory: :target
    association :matching_target, factory: :target
  end
end
