# frozen_string_literal: true

module V1
  # Song serializer class
  class SongSerializer < BaseSerializer
    attributes :id, :name, :duration, :genre, :album_id, :featured
    attribute :description, if: :featured?
    attribute :here, if: :featured?
    
    def featured?
      object.featured?
    end
  
    def here
      object.here.url
    end
    
    def album_id
      object.album.id.to_s
    end
  end
end
