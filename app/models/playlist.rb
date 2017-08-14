# frozen_string_literal: true

# Playlist Model
class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String

  has_and_belongs_to_many :songs

  validates_presence_of :name
end
