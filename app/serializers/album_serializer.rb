# frozen_string_literal: true

class AlbumSerializer < BaseSerializer
  attributes :id, :name, :art, :artist_id
  
  has_many :songs
  
  def featured?
    object.featured?
  end
  
  def art
    object.art.url
  end
  
  def artist_id
    object.artist.id.to_s
  end
end
