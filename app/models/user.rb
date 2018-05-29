class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :photo, PhotoUploader

  after_validation :default_photo
  
  has_many :hashtags
  has_many :tags, through: :hashtags
  has_many :tag_restaurants, through: :hashtags, source: :restaurant

  def admin?
    self.role == "admin"
  end
end
