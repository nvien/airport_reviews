class Airport < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :reviews

  validates :name, presence: true
  validates :city, presence: true
  validates :IATA, presence: true
end
