# frozen_string_literal: true

FactoryBot.define do
  factory :manuscript do
  end
  factory :user do
    sequence :email do |n|
      "chaucerpants#{n}@digital-sel.com"
    end
    sequence :first_name do |n|
      "Geoffery#{n}"
    end
    sequence :last_name do |n|
      "Chaucer#{n}"
    end
    password { Faker::Crypto.sha1 }
    factory :admin do
      admin { true }
    end
  end
end
