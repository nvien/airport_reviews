class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :reviews, dependent: :destroy #To delete all reviews associated with a particular user when that user account is deleted

  validates :first_name, presence: true
  validates :last_name, presence: true
end
