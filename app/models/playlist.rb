class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String

  has_many :songs

  validates_presence_of :name
end
