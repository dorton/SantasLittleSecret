class User < ApplicationRecord
  attachment :profile_image
  has_many :user_seasons
  has_many :seasons, through: :user_seasons
end
