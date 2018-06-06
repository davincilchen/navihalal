class Restaurant < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  validates_uniqueness_of :name, :scope => :address
  validates :name, :address, :tel, presence: true
  geocoded_by :address        #從address欄位取出地址
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  #將取出的地址自動轉為經緯度分別存在 latitude、longitude 欄位
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, unless: ->(obj) { obj.address.present? },
                   if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }

  attr_accessor :raw_address

  geocoded_by :raw_address
  after_validation -> {
    self.address = self.raw_address
    geocode
  }, if: ->(obj){ obj.raw_address.present? and obj.raw_address != obj.address }

  after_validation :reverse_geocode, unless: ->(obj) { obj.raw_address.present? },
                  if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }
                    
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

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Restaurant.create! row.to_hash
    end
  end
end
