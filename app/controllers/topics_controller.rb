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
    topic = Topic.new(params[:topic].permit(:title, :description))
    if topic.save_with_speaker session[:cas_user]
      redirect_to topics_path
    else
      render 'new'
    end
  end

  def vote_for
    topic = Topic.find(params[:id])
    if topic.speakers.pluck(:name).include?(session[:cas_user])
      render text: "You Can't vote for your own topic", status: :unprocessable_entity
    elsif topic.voters.pluck(:name).include?(session[:cas_user])
      render text: "You can't vote more than once to the same topic", status: :unprocessable_entity
    else
      topic.voters << User.find_or_create_by(name: session[:cas_user])
      render text: topic.voters.length, status: :ok
    end
  end
  
end
