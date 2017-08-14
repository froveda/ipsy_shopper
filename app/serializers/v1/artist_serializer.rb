# frozen_string_literal: true

module V1
  # Artist serializer class
  class ArtistSerializer < BaseSerializer
    attributes :id, :name, :bio
    
    has_many :albums
  end
end
