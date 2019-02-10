# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  root to: 'home#index'

  resources :users, only: %i[index create update destroy show]
  resources :manuscripts, only: %i[index show]

  get 'status', to: 'status#index'
end
