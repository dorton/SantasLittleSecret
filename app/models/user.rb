class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attachment :profile_image
  validates :email, presence: true
  has_many :user_seasons, dependent: :destroy
  has_many :seasons, through: :user_seasons, dependent: :destroy
  has_many :user_famorgs
  has_many :famorgs, through: :user_famorgs
  has_one :st_nick

  def name
    "#{first_name} #{last_name}"
  end



end
