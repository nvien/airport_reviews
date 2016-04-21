class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :airport

  validates :rating, presence: true, numericality: true, inclusion: { in: 1..5, message: 'must be between 1-5' }
end
