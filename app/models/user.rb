class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :photo, PhotoUploader

  after_validation :default_photo
  
  has_many :hashtags, dependent: :destroy
  has_many :tags, through: :hashtags
  has_many :tag_restaurants, through: :hashtags, source: :restaurant

  has_many :collects, dependent: :destroy
  has_many :collected_restaurants, through: :collects, source: :restaurant
  
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
end
