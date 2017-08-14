# frozen_string_literal: true

class ArtistSerializer < BaseSerializer
  attributes :id, :name, :bio
  
  has_many :albums
end
