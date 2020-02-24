# frozen_string_literal: true

Rails.application.routes.draw do
  # match "*path", via: [:options], to: lambda { |_| [204, { "Content-Type" => "text/plain" }] }
  # Login related routes
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  # Bill related routes
  resources :bills, only: [:index]

  # User related routes
  resources :users, only: %i[create show index update]
  post '/username_exists', to: 'users#username_exists'
  post '/email_exists', to: 'users#email_exists'

  # User Watchlists
  resources :bill_users, only: %i[create update]
  # User Categories
  resources :category_users, only: %i[create update]
end
