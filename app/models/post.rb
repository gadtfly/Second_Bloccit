class Post < ActiveRecord::Base
    has_many :comments
    #adding this line per bloc instructions
    belongs_to :user

    default_scope { order('created_at DESC') }
end
