class Album
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  mount_uploader :art, ImageUploader
  
  has_many :songs, dependent: :destroy
  belongs_to :artist

  validates_presence_of :name, :art
end
