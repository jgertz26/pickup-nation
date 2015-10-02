class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  validates :email, presence: true
  validates :username, presence: true

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
