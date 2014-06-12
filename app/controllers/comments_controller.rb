 class CommentsController < ApplicationController

   def create 
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments 
    @comment = Comment.new(comment_params)

    authorize @comment

    @comment.user = current_user
    @comment.post = @post
    @new_comment = Comment.new

    if @comment.save
      flash[:notice] = "Comment was saved, its soul should be clean now."
    else
      flash[:error] = "There was an error saving the comment, please purify its soul."
    end

    redirect_to topic_post_path(@topic, @post)

    # respond_with(@comment) do |f|
    #   f.html {redirect_to [@topic, @post] }
    # end
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
   redirect_to [@topic, @post]
  else
    flash[:error] = "Comment could not be terminated...It'll be back."
    redirect_to [@topic, @post]
  end
end

private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
