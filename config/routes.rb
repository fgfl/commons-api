# frozen_string_literal: true

Rails.application.routes.draw do
  
  get 'test_write_db' => 'test_db#create'

  post '/users' => 'users#create'

end
