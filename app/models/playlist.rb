# frozen_string_literal: true

# Playlist Model
class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String

  has_and_belongs_to_many :songs

  validates_presence_of :name
  
  def remove_songs(song_ids_to_remove)
    song_ids_to_remove = song_ids_to_remove.collect { |song_id| BSON::ObjectId(song_id) }
  
    self.song_ids = song_ids - song_ids_to_remove
    
    save
  end
end
