# frozen_string_literal: true

module V1
  # Song serializer class
  class SongSerializer < BaseSerializer
    attributes :id, :name, :duration, :genre, :featured
    attribute :description, if: :featured?
    attribute :here, if: :featured?
  
    belongs_to :album
    has_many :playlists
  
    def featured?
      object.featured?
    end
  
    def here
      object.here.url
    end
  end
end
