# frozen_string_literal: true

Rails.application.routes.draw do
  # Login related routes
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  # Bill related routes
  resources :bills, only: [:index]
  
  # User related routes
  resources :users, only: [:create, :show, :index, :update]
end
