class Restaurant < ApplicationRecord
  include PublicActivity::Model
  tracked
  
  mount_uploader :photo, PhotoUploader
  geocoded_by :address        #從address欄位取出地址
  after_validation :geocode   #將取出的地址自動轉為經緯度分別存在 latitude、longitude 欄位
  after_validation :default_photo

  has_many :meals, dependent: :destroy
  accepts_nested_attributes_for :meals, :allow_destroy => true, :reject_if => :all_blankqui
  has_many :mealed_users, through: :meals, source: :user

  has_many :hashtags, dependent: :destroy
  has_many :tags, through: :hashtags
  has_many :tag_users, through: :hashtags, source: :user

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user
  include RestaurantsHelper

end
