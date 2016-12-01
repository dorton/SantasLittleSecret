# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Season.create(year: '2016-12-25')

def create_groups
  group = Famorg.new
  group.name = Faker::Hacker.say_something_smart
  group.seasons << Season.last
  group.save!
  group
end




def create_me(group)
  user = User.new
  user.first_name = "Brian"
  user.last_name = "Dorton"
  user.email = "dorton@gmail.com"
  user.password = "12345678"
  user.want = "IDK, an iWatch?"
  user.remote_profile_image_url = "https://avatars3.githubusercontent.com/u/662645?v=3&s=460"
  user.famorgs << group
  user.seasons << group.seasons.last
  user.admin = true
  user.save!
  user
end

def create_users(group)
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = Faker::Internet.password(8)
  user.want = Faker::Hacker.say_something_smart
  user.remote_profile_image_url = Faker::Avatar.image
  user.famorgs << group
  user.seasons << group.seasons.last
  user.admin = false
  user.save!
  user
end

4.times do
  create_groups
end

create_me(Famorg.first)

Famorg.all.each do |group|
  (5..8).to_a.sample.times do
    create_users(group)
  end
end
