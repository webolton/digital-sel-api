# frozen_string_literal: true

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/puma'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
