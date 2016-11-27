class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attachment :profile_image
  has_many :user_seasons
  has_many :seasons, through: :user_seasons

  def name
    "#{first_name} #{last_name}"
  end
end
