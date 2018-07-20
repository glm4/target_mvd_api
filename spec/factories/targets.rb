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

FactoryBot.define do
  factory :target do
    title     { Faker::Lorem.word }
    lat       { Faker::Address.latitude }
    lng       { Faker::Address.longitude }
    radius    { Faker::Number.decimal(3) }
    topic
    user

    transient do
      origin { { lat: -34.9, lng: -56.2 } }
    end

    trait :within_range do
      lat  { origin[:lat] }
      lng  { origin[:lng] }
    end
    trait :out_of_range do
      lat  { origin[:lat] * -1 }
      lng  { origin[:lng] * -1 }
    end
  end
end
