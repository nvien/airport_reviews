class Airport < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
