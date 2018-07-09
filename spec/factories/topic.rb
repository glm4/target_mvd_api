FactoryBot.define do
  factory :topic do
    name    { Faker::Lorem.word }
    icon    { Faker::File.file_name }
  end
end
