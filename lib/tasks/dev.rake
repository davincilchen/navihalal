# frozen_string_literal: true

namespace :dev do
  task fake_all: :environment do
    # Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    # Rake::Task['dev:fake_friendship'].execute
    Rake::Task['dev:fake_restaurant'].execute
    # Rake::Task['dev:fake_comment'].execute
    # Rake::Task['dev:fake_collect'].execute
    # Rake::Task['dev:fake_sort'].execute
  end

  task fake_user: :environment do
    num = [*0..72].sample(30)
    30.times do |i|
      avatar = "pic1_#{num[i].to_s.rjust(3, '0')}.jpg"
      User.create!(
        id: i + 3,
        name: FFaker::Name.first_name,
        photo: File.new(Rails.root.join('app', 'assets', 'images', avatar)),
        email: FFaker::Internet.email,
        intro: FFaker::Lorem.paragraph,
        password: '123123',
        role: 'normal',
        country: FFaker::Address.country,
        residence: FFaker::Address.city
      )
    end
    puts 'have created fake users'
    puts "now you have #{User.count} users data"
  end

  task fake_restaurant: :environment do
    Restaurant.destroy_all
    200.times do |i|
      # photo = "pic1_#{rand(72).to_s.rjust(3, '0')}.jpg"
      file = File.new(Rails.root.join('app', 'assets', 'images', "pic_#{rand(72).to_s.rjust(3, '0')}.jpg"))
      Restaurant.create!(
        id: i + 1,
        photo: file,
        name: FFaker::Lorem.sentence(rand(1..2)),
        tel: FFaker::PhoneNumberAU.home_work_phone_number,
        address: FFaker::Address.street_address,
        intro: FFaker::Lorem.sentence,
        user_id: User.all.sample.id,
        open_hour: ['06:00' '10:00' '16:00' '22:00'].sample,
        close_hour: ['11:00' '15:00' '21:00' '03:00'].sample
      )
    end
    puts 'have created fake restaurants'
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_sort: :environment do
    Sort.destroy_all
    Post.all.each do |post|
      categories = Category.all.sample(2)
      rand(2).times do |i|
        post.sorts.create!(
          category_id: categories[i].id
        )
      end
    end
    puts 'have created fake sorts'
    puts "now you have #{Sort.count} sorts data"
  end

  task fake_comment: :environment do
    Comment.destroy_all
    Post.all.each do |post|
      rand(6).times do
        Comment.create!(
          post: post,
          content: FFaker::Lorem.paragraph,
          user: User.all.sample
        )
      end
    end
    puts 'have created fake comments'
    puts "now you have #{Comment.count} comments data"
  end

  task fake_collect: :environment do
    Collect.destroy_all
    User.all.each do |user|
      rand(10).times do
        user.collects.create!(
          user_id: user.id,
          post_id: Post.all.sample.id
        )
      end
    end
    # Post.all.each do |post|
    #   post.collects_count = Collect.where(post_id: post.id).count
    #   post.save
    # end
    puts 'have created fake collects'
    puts "now you have #{Collect.count} collects data"
  end

  task fake_friendship: :environment do
    User.all.each do |user|
      rand_user = User.where.not(id: user).sample(5)
      rand(5).times do |i|
        user.friendships.create!(
          user_id: user.id,
          friend_id: rand_user[i].id,
          accept: [true, false].sample
        )
      end
    end

    puts 'have created fake friendship'
    puts "now you have #{Friendship.count} friendships data"
  end

  # task fake_p: :environment do
  #   uploaders = Restaurant.first(10).map(&:image)
  #   Restaurant.last(490).each do |restaurant|
  #     restaurant.image = uploaders.sample
  #   end
  #   puts "other fake image"
  # end
end
