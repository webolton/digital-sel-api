# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :user do
    email    "email#{Random.rand(10)}@email.com"
    password SecureRandom.base58
  end

  factory :admin, class: User do
    email    "admin#{Random.rand(10)}@email.com"
    password SecureRandom.base58
    admin    true
  end
end
