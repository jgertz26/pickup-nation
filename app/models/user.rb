class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
