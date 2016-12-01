class Comment < ApplicationRecord
  validates :body, presence: true
  has_many :users, through: :user_comments, dependent: :destroy
  has_many :user_comments
end
