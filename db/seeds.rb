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

def create_me(email, password, first_name, last_name, want)
      @user = User.invite!(email: email) do |u|
        u.skip_invitation = true
      end
      token = Devise::VERSION >= "3.1.0" ? @user.instance_variable_get(:@raw_invitation_token) : @user.invitation_token
      User.accept_invitation!(invitation_token: token, password: password, password_confirmation: password, first_name: first_name, last_name: last_name, want: want, remote_profile_image_url: Faker::Avatar.image)

      puts "Created User #{email} with password #{password}"
      @user
    end


create_me("123@123.com", "12345678", "bob", "lawblah", "IDK, an iwatch?")


# def create_me(group)
#   user = User.new
#   user.first_name = "Bob"
#   user.last_name = "Blahblah"
#   user.email = "123@123.com"
#   user.password = "12345678"
#   user.want = "IDK, an iWatch?"
#   user.remote_profile_image_url = Faker::Avatar.image
#   user.famorgs << group
#   user.seasons << group.seasons.last
#   user.admin = true
#   user.save!
#   user
# end

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

# create_me(Famorg.first)

# Famorg.all.each do |group|
#   (5..8).to_a.sample.times do
#     create_users(group)
#   end
# end

# def adduser(email, password)
#       @user = User.invite!(:email => email) do |u|
#         u.skip_invitation = true
#       end
#       token = Devise::VERSION >= "3.1.0" ? @user.instance_variable_get(:@raw_invitation_token) : @user.invitation_token
#       User.accept_invitation!(:invitation_token => token, :password => password, :password_confirmation => password)
#
#       puts "Created User #{email} with password #{password}"
#       @user
#     end
#
#     user1 = adduser("user@example.com", "123456")
#     user2 = adduser("user2@example.com", "123456")
#     user3 = adduser("user3@example.com", "123456")


def adduser(email, password, famorg)
  @user = User.invite!(email: email)
  token = Devise::VERSION >= "3.1.0" ? @user.instance_variable_get(:@raw_invitation_token) : @user.invitation_token
  accepted_user = User.accept_invitation!(:invitation_token => token, :password => password, :password_confirmation => password)
  accepted_user.famorgs << famorg
  puts "Created User #{email} with password #{password}"
  @user
end
