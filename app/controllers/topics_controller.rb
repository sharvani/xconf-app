class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    respond_to do |format|
      format.html { render partial: 'topic' }
    end
  end

  def create
    @topic = Topic.new(params[:topic].permit(:title, :description))
    if @topic.save
      redirect_to topics_path
    else
      render 'new'
    end
  end

end
