# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email, presence:   { message: 'Email cannot be blank' },
                    uniqueness: { message: 'Email has already been taken' },
                    format:     { with: Devise.email_regexp, message: 'Invalid email' }
  validates :first_name, presence: { message: 'First name cannot be blank' }
  validates :last_name, presence: { message: 'Last name cannot be blank' }
end
