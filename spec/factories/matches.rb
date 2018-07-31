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

FactoryBot.define do
  factory :match do
    last_message { Faker::Hacker.say_something_smart }
    unread_messages { Faker::Number.number(1) }
    association :original_target, factory: :target
    association :matching_target, factory: :target
  end
end
