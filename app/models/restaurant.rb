class Restaurant < ApplicationRecord
  include PublicActivity::Model
  tracked only: :create, owner: Proc.new{ |controller, model| controller &&controller.current_user }
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy


  mount_uploader :photo, PhotoUploader
  validates_uniqueness_of :name, :scope => :address
  validates :name, :address, :tel, presence: true
  geocoded_by :address        #從address欄位取出地址
  after_validation :geocode
  #將取出的地址自動轉為經緯度分別存在 latitude、longitude 欄位

  after_validation :default_photo

  belongs_to :user

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
