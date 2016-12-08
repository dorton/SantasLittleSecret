class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :user, dependent: :destroy
  belongs_to :famorg, dependent: :destroy
end
