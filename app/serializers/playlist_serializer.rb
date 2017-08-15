# frozen_string_literal: true

# Playlist serializer class
class PlaylistSerializer < BaseSerializer
  attributes :id, :name
  
  has_many :songs
end
