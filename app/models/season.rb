class Season < ApplicationRecord
  validates :year, presence: true
  has_many :famorgs, through: :season_famorgs
  has_many :season_famorgs, dependent: :destroy
  has_many :user_seasons, dependent: :destroy
  has_many :users, through: :user_seasons
end
