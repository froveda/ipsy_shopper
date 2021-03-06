# frozen_string_literal: true

# Album Model
class Album
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  mount_uploader :art, ImageUploader

  has_many :songs, dependent: :destroy
  belongs_to :artist

  validates_presence_of :name, :art

  def remove_songs(song_ids_to_remove)
    songs.where(:id.in => song_ids_to_remove).destroy_all
  end
end
