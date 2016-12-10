class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  attachment :profile_image
  validates :email, presence: true
  has_many :comments, dependent: :destroy
  has_many :user_seasons, dependent: :destroy
  has_many :seasons, through: :user_seasons
  has_many :user_famorgs, dependent: :destroy
  has_many :famorgs, through: :user_famorgs
  has_one :st_nick

  def name
    "#{first_name} #{last_name}"
  end

end
