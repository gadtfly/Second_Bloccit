class FavoritesController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite

    if favorite.save
      flash[:notice] = "This post has become one of your favorites...!"
      redirect_to [@topic, @post]
    else
      flash[:error] = "We were unable to add this to your favorites, please try again. Sorry for the inconveniences."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])
    authorize favorite

    if favorite.destroy
      flash[:notice] = "This was an unwanted favorite..."
      redirect_to [@topic, @post]
    else
      flash[:error] = "We were unable to remove one of your favorites, please try again and again."
      redirect_to [@topic, @post]
    end
  end
end
