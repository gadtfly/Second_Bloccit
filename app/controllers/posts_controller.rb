class PostsController < ApplicationController
  #what happened here? where are hte next lines?
  def index
    @posts = Post.all
    authorize @posts 
  end

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    
  end

  def new
      @topic = Topic.find(params[:topic_id])
      @post = Post.new
      authorize @post 
  end

  def create 
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    @post.topic = @topic
    
    authorize @post 
    if @post.save
      redirect_to [@topic, @post], notice: "This post was saved succesfully!!!"
    else
      flash[:error] = "There was a problem saving your post, please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post 
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Your Post was Updated!!!"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving your post. Please try AGAIN."
      render :new
    end
  end
end

