# frozen_string_literal: true

module V1
  # Playlist API Controller
  class PlaylistsController < V1::BaseController
    before_action :set_resource, only: %i[show update destroy add_songs]
    
    def add_songs
      @resource.songs << playlist_songs_params[:song_ids].collect { |song_id| Song.find(song_id) }
      
      if @resource.save
        render json: @resource
      else
        render json: @resource.errors, status: :unprocessable_entity
      end
    rescue Mongoid::Errors::DocumentNotFound => e
      render json: e.json, status: :not_found
    end
    
    private
    
    def set_collection
      @collection = Playlist.all
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Playlist.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def resource_params
      params.require(:playlist).permit(:name, song_ids: [])
    end
    
    def playlist_songs_params
      params.require(:playlist).permit(song_ids: [])
    end
  
    def resource_class
      Playlist
    end
  end
end
