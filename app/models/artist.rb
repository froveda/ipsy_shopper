# frozen_string_literal: true

# Artist Model
class Artist
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :bio, type: String
  
  has_many :albums, dependent: :destroy

  validates_presence_of :name
end
