FactoryBot.define do
  factory :user do
    email { "hello_#{Random.rand(100..300)}@homeloan.com" }
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    user_uuid { SecureRandom.uuid }
    password { 'HomeLoan.999' }
  end
end
