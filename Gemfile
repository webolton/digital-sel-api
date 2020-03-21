# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

gem 'cancancan', '~> 2.0'
gem 'coveralls', require: false
gem 'devise'
gem 'devise-jwt', '~> 0.5.9'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'dry-configurable', '0.9.0' # pin version because later version conflicts with devise-jwt
gem 'pg'
gem 'puma', '~> 3.12' # app server
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :test do
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop-rails'
  gem 'rubocop-rails_config'
  gem 'rubocop-rspec'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
