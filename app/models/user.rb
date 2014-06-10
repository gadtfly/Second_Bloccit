class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         #added :confirmable to the previous line a
  has_many :comments
  has_many :posts
  mount_uploader :avatar, AvatarUploader

  def role?(base_role)
    role == base_role.to_s
  end
end
