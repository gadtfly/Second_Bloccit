class PostsController < ApplicationController
  #what happened here? where are hte next lines?
  def index
    @posts = Post.all
    authorize @posts 
  end

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @comments = @post.comments
    authorize @topic
    #@comment = comment.new        #why was this line missing? does the order of these 5 lines matter?
  end

  def new
      @topic = Topic.find(params[:topic_id])
      @post = Post.new
      authorize @post 
  end

  def create 
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post 
    if @post.save
      redirect_to [@topic, @post], notice: "This post was saved succesfully!!!"
    else
      flash[:error] = "There was a problem saving your post, please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully, now grab another."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post, please try again."
      render :show
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
    if @post.update_attributes(post_params)
      flash[:notice] = "Your Post was Updated!!!"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving your post. Please try AGAIN."
      render :new
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end

