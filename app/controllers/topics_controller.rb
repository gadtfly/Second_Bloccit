class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def show
    @topic = Topic.find(params[:id])
    #cambiar o agregar?
    @posts = @topic.posts
    #authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic 
  end

  # POST /topics
  # params = {topic: {title: 'asdfasdfaf', body: 'qwerqwerwqewrw'}}
  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "There was an error creating topic, please try again!!!"
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic 
    if @topic.update_attributes(topic_params)
       redirect_to @topic 
    else
      flash[:error] = "There was an error saving topic, please try again!!!."
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end
end
