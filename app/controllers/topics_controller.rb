class TopicsController < ApplicationController

  def index
    @topics = Topic.all.order('id desc')
    @current_user = session[:cas_user]
    @all_talks_active = 'active'
  end

  def new
    @topic = Topic.new
    respond_to do |format|
      format.html { render partial: 'topics/partials/form' }
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @has_voted = @topic.voters.pluck(:name).include?(session[:cas_user])
    respond_to do |format|
      format.html { render partial: '/topics/partials/topic' }
    end
  end

  def create
    @topic = Topic.new(params[:topic].permit(:title, :category, :description))
    if @topic.save_with_registerer session[:cas_user]
      respond_to do |format|
        format.json { render json: @topic, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(params[:topic].permit(:title, :category, :description))
      redirect_to topics_path, {notice: 'You have successfully updated the topic'}
    else
      render 'edit'
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    if topic.delete
      redirect_to topics_path
    end
  end

  def topics_list
    @topics = Topic.all
    respond_to do |format|
      format.xls
    end
  end

  def vote_for
    topic = Topic.find(params[:id])
    current_user = session[:cas_user]
    user = User.find_or_create_by(name: current_user)

    if topic.speakers.pluck(:name).include?(current_user)
      render text: "Sorry, You Can't vote for your own topic", status: :unprocessable_entity
    elsif user.voted_topics.length >= 3
      render text: "Sorry, You can't vote for more than three topics", status: :unprocessable_entity
    else
      topic.voters << User.find_or_create_by(name: current_user)
      render nothing: true, status: :ok
    end
  end

  def revoke_vote
    topic = Topic.find(params[:id])
    topic_voters = topic.voters
    current_user = session[:cas_user]
    topic_voters.each { |voter|
      if voter.name == current_user
        topic_voters.delete(voter)
      end
    }
    render nothing: true, status: :ok
  end

  def get_speakers
    @topic_id = params[:id]
    @speakers = Topic.find(@topic_id).speakers
    if @speakers.length == 5
      rendering_partial = 'limit_reached'
    else
      rendering_partial = 'speakers_list'
    end
    respond_to do |format|
      format.html { render partial: '/topics/partials/' + rendering_partial }
    end
  end

  def add_speakers
    topic = Topic.find(params[:id])
    has_added, rendering_text = topic.add_speakers_to_topic params[:speakers]
    if has_added
      render nothing: true, status: :ok
    else
      render text: rendering_text, status: :unprocessable_entity
    end
  end

end
