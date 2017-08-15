# frozen_string_literal: true

# Artist serializer class
class ArtistSerializer < BaseSerializer
  attributes :id, :name, :bio
  
  has_many :albums
end
