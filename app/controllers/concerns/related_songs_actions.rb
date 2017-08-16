# frozen_string_literal: true

# Actions related with songs relationships (has_many)
module RelatedSongsActions
  extend ActiveSupport::Concern
  
  included do
    before_action :set_songs, only: :add_songs
  end
  
  def add_songs
    if resource.save
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: e.json, status: :not_found
  end

  def delete_songs
    if resource.remove_songs(songs_params[:song_ids])
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_songs
    resource.songs << songs_params[:song_ids].collect { |song_id| Song.find(song_id) }
  end
end
