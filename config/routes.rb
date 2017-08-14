# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  concern :api_base do
    resources :albums
    resources :artists
    resources :songs
  end

  namespace :v1 do
    concerns :api_base
  end
end
