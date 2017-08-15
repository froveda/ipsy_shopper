# frozen_string_literal: true

# Song serializer class
class PlaylistSerializer < BaseSerializer
  attributes :id, :name
  
  has_many :songs
end
