# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email, presence:   { message: 'Email cannot be blank' },
                    uniqueness: { message: 'Email has already been taken' }
  validates_format_of :email, with: Devise::email_regexp, message: "Email is invalid"
  validates :password, presence: { message: 'Password cannot be blank' }
  validates :first_name, presence: { message: 'First name cannot be blank'}
  validates :last_name, presence: { message: 'Last name cannot be blank' }
end
