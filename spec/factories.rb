# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :user do
    email "email#{Random.rand(10)}@email.com"
    password SecureRandom.base58
  end
end
