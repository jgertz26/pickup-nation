class User < ActiveRecord::Base
  has_many :meetups

  mount_uploader :avatar, AvatarUploader

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def creator?(meetup)
    meetup.user == self
  end
end
