class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validate :user, presence: true
  validate :post, presence: true
end
