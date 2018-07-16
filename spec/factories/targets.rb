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
  end
end
