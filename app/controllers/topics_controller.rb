class TopicsController < ApplicationController

  def index
    @topics = Topic.all.order('id desc')
    @current_user = session[:cas_user]
    @topicUserVoteStatus = Topic.new.getUserTopicVoteStatus(@topics, @current_user)
    @all_talks_active = 'active'
  end

  def new
    @topic = Topic.new
    @current_speakers = session[:cas_user]
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
    if @topic.save_with_registerer_and_speakers(session[:cas_user], params[:speakers])
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
    @current_speakers = @topic.speakers.pluck(:name).map { |x| x }.join(',')
    respond_to do |format|
      format.html { render partial: 'topics/partials/form' }
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_with_speakers(params)
      respond_to do |format|
        format.json { render json: @topic, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
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
    topic.voters << User.find_or_create_by(name: session[:cas_user])
    render nothing: true, status: :created
  end

  def revoke_vote
    topic = Topic.find(params[:id])
    topic_voters = topic.voters
    topic_voters.each { |voter|
      if voter.name == session[:cas_user]
        topic_voters.delete(voter)
      end
    }
    render nothing: true, status: :ok
  end

end
