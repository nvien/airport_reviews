class Airport < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  searchkick

  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :IATA, presence: true
end
