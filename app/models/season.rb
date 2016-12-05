class Season < ApplicationRecord
  validates :year, presence: true
  has_many :famorgs, through: :season_famorgs, dependent: :destroy
  has_many :season_famorgs
  has_many :user_seasons
  has_many :users, through: :user_seasons, dependent: :destroy
end
