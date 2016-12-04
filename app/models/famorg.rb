class Famorg < ApplicationRecord
  validates :name, presence: true

  has_many :users, through: :user_famorgs, dependent: :destroy
  has_many :user_famorgs
  has_many :seasons, through: :season_famorgs, dependent: :destroy
  has_many :season_famorgs
end
