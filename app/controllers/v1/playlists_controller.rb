# frozen_string_literal: true

module V1
  # Playlist API Controller
  class PlaylistsController < ApplicationController
    include BasicApiActions
    include RelatedSongsActions

    private
    
    def resource_params
      params.require(:playlist).permit(:name, song_ids: [])
    end
    
    def songs_params
      params.require(:playlist).permit(song_ids: [])
    end
  
    def resource_class
      Playlist
    end
  end
end
