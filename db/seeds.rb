# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Category.destroy_all

# category_list = [
#   { name: 'cat' },
#   { name: 'dog' },
#   { name: 'hamster' }
# ]

# category_list.each do |category|
#   Category.find_or_create_by(name: category[:name])
# end
# puts 'Category created!'

# Default admin
User.destroy_all
photo = "pic1_#{rand(72).to_s.rjust(3, '0')}.jpg"
User.create(
  id: 1,
  name: 'Tony',
  email: '123@123.123',
  password: '123123',
  role: 'admin',
  intro: 'This is gourmet.',
  country: 'Taiwan',
  residence: 'Tainan',
  birthday: '1983/12/08',
  photo: File.new(Rails.root.join('app', 'assets', 'images', photo))
)

photo = "pic1_#{rand(72).to_s.rjust(3, '0')}.jpg"
User.create(
  id: 2,
  name: 'Cococa',
  email: 'admin@example.com',
  password: '12345678',
  role: 'admin',
  intro: 'This is gourmet.',
  country: 'Taiwan',
  residence: 'Chiayi',
  birthday: '1982/11/26',
  photo: File.new(Rails.root.join('app', 'assets', 'images', photo))
)
puts 'Default admin created!'

Tag.destroy_all
Tag.create!( name: "Halal")
Tag.create!( name: "Muslim boss")
Tag.create!( name: "Seafood")
Tag.create!( name: "Vegan")
puts "have created #{Tag.count} tags"

# add halal restaurant by csv
# Restaurant.destroy_all
csv_text = File.read(Rails.root.join('lib', 'seeds', 'halal_restaurant.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Restaurant.new
  t.name = row['name']
  t.tel = row['tel']
  t.address = row['address']
  t.business_hour = row['business_hour']
  t.save
  puts "#{t.name} saved"
end

puts "There are now #{Restaurant.count} rows in the restaurants table"

# 自動運行geocoder 將地址轉換成經緯度 間隔1秒、查詢10筆、上限100筆
# Rake::Task['geocode:all CLASS=Restaurant'].execute
