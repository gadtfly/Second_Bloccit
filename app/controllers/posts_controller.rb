class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
      @post = Post.new
  end

  def create 
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    if @post.save
      flash[:notice] = "This post was saved succesfully!!!"
      redirect_to @post 
    else
      flash[:error] = "There was a problem saving your post, please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Your Post was Updated!!!"
      redirect_to @post 
    else
      flash[:error] = "There was an error saving your post. Please try AGAIN."
      render :edit
    end
end
end
