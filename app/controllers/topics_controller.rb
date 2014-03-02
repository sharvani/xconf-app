class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    speakers_topic = SpeakersTopics.find_by(topic_id: @topic.id, has_registered: true)
    @registered_by = User.where(id: speakers_topic.user_id).pluck(:name).first
    respond_to do |format|
      format.html { render partial: 'topic' }
    end
  end

  def create
    @topic = Topic.new(params[:topic].permit(:title, :description))
    if @topic.save_with_speaker session[:cas_user]
      redirect_to topics_path
    else
      render 'new'
    end
  end

  def vote_for
    topic = Topic.find(params[:id])
    current_user = session[:cas_user]
    if topic.speakers.pluck(:name).include?(current_user)
      render text: "Sorry, You Can't vote for your own topic", status: :unprocessable_entity
    elsif topic.voters.pluck(:name).include?(current_user)
      render text: "Sorry, You can't vote more than once to the same topic", status: :unprocessable_entity
    else
      topic.voters << User.find_or_create_by(name: current_user)
      render text: topic.voters.length, status: :ok
    end
  end

  def contribute_for
    topic = Topic.find(params[:id])
    current_user = session[:cas_user]
    if topic.speakers.pluck(:name).include?(current_user)
      render text: 'You have already added yourself as a speaker', status: :unprocessable_entity
    else
      topic.speakers << User.find_or_create_by(name: current_user)
      render text: current_user, status: :ok
    end
  end

end
