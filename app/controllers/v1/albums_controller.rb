# frozen_string_literal: true

module V1
  # Album API Controller
  class AlbumsController < ApplicationController
    include BasicApiActions
    include RelatedSongsActions
    
    private
    
    def resource_params
      params.require(:album).permit(:name, :art, :artist_id)
    end

    def songs_params
      params.require(:album).permit(song_ids: [])
    end
  
    def resource_class
      Album
    end
  end
end
