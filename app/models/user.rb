# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email, presence: true, uniqueness: { message: 'Email has already been taken.' }
  validates :password, presence: true
end
