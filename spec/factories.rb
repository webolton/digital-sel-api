# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :user do
    email      "email#{Random.rand(10)}@email.com"
    first_name "Geoffery#{Random.rand(200)}"
    last_name  "Chaucer#{Random.rand(200)}"
    password   SecureRandom.base58
  end

  factory :admin, class: User do
    admin    true
  end
end
