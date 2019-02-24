# frozen_string_literal: true

FactoryBot.define do
  factory :witness do
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

  factory :saints_legend do
    sequence(:siglum) { |n| "b#{n}" }
    title { "Saint #{Faker::Name.first_name} the confessor that goodman was enoug" }
    # date nil
    # summary nil
    position { rand(1..80) }
    incipit { "Saint #{Faker::Name.first_name} the confessor that goodman was enoug" }
    imev_number { "2#{rand(1..999)}" }
    nimev_number { "2#{rand(1..999)}" }
    dimev_number { "4#{rand(1..999)}" }
    # notes nil
    versification { 'two-line, aa' }
    calendar_day { Time.now.strftime('%d %B') }
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
