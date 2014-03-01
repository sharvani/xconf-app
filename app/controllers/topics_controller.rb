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
      render text: 'You Cant vote for your own topic', status: :unprocessable_entity
    else
      topic.update_attribute(:votes, topic.votes += 1)
      render text: topic.votes, status: :ok
    end
  end

  private
  def fetch_speakers_names(topic)
    speakers = []
    topic.speakers.each { |speaker|
      speakers << speaker.name
    }
    speakers
  end

end
