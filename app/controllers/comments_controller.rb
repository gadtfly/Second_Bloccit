 class CommentsController < ApplicationController
  respond_to :html, :js

   def create 
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments 

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new
    
    authorize @comment

    if @comment.save
      flash[:notice] = "The comment was created successfully!"
    else
      flash[:error] = "There was an error saving the comment, please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment

    @comment.update_attributes(comment_params)
    redirect_to topic_post_path(@topic, @post)
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

def destroy
  @topic = Topic.find(params[:topic_id])
  @post = @topic.posts.find(params[:post_id])
  @comment = @post.comments.find(params[:id])
  authorize @comment

  if @comment.destroy
   flash[:notice] = "Comment was safely terminated, thank you."
  else
    flash[:error] = "Comment could not be terminated...It'll be back."
  end
  respond_with(@comment) do |f|
    f.html { redirect_to [@topic, @post] }
  end
end

private

  def comment_params
    params.require(:comment).permit(
      :body,
      :post_id
      )
  end
end
