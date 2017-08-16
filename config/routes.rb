# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  concern :api_base do
    put 'albums/:id/add_songs', to: 'albums#add_songs', as: :albums_add_songs
    delete 'albums/:id/delete_songs', to: 'albums#delete_songs', as: :albums_delete_songs
    resources :albums
    
    resources :artists
    
    put 'playlists/:id/add_songs', to: 'playlists#add_songs', as: :playlists_add_songs
    delete 'playlists/:id/delete_songs', to: 'playlists#delete_songs', as: :playlists_delete_songs
    resources :playlists
    
    resources :songs
  end

  namespace :v1 do
    concerns :api_base
  end
end
