# frozen_string_literal: true

FactoryBot.define do
  factory :witness do
  end

  factory :saints_legend do
  end

  factory :manuscript do
    # "date": null,
    # "description": null,
    # "dialect": null,
    # "scribal_description": null,
    # "provenance": null,
    # "url": null,
    # "sc_number": null,
    # "notes": null,
    # "status": null,
    # "owned": "true",
    # "price": 0,
    # "major_ms": true
    sequence(:shelfmark) { |n| "London, British Library, Harley #{n}" }
    sequence(:siglum) { |n| "H#{n}" }
    country { 'UK' }
    city { 'London' }
    repository { 'British Library' }
  end

  factory :user do
    sequence(:email) { |n| "chaucerpants#{n}@digital-sel.com" }
    sequence(:first_name) { |n| "Geoffery#{n}" }
    sequence(:last_name) { |n| "Chaucer#{n}" }
    password { Faker::Crypto.sha1 }
    factory :admin do
      admin { true }
    end
  end
end
