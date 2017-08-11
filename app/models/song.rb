# frozen_string_literal: true

# Song Model
class Song
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :duration, type: Integer, default: 0 # duration in seconds
  field :genre, type: String
  field :featured, type: Boolean, default: false
  field :description, type: String
  mount_uploader :here, ImageUploader
  
  belongs_to :album
  belongs_to :playlist

  validates_presence_of :name, :duration, :genre
  validates_numericality_of :duration, only_integer: true, greater_than_or_equal_to: 0
end
