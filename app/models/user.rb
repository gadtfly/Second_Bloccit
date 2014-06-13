class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :comments
  has_many :posts
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def self.top_rated
    self.select('users.*'). #selecciona todos los atributos del usuario
      select('COUNT(DISTINCT comments.id) AS comments_count'). #cuenta los comentarios del usuario
      select('COUNT(DISTINCT posts.id) AS posts_count'). #cuenta los posts del usuario
      select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank'). #suma los comentarios y los posts y asigna variable rank
      joins(:posts). #posts-table con users-table via the user-id
      joins(:comments). #igual pero con comments
      group('users.id'). #instructs the DB to group the results so each user has its own row
      order('rank DESC')  #no period? tells DB to order results descending
  end 


  def role?(base_role)
    role == base_role.to_s
  end

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end

  def voted(post)
    self.votes.where(post_id: post.id).first
  end
  
  
  private

end
