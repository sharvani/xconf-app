class TopicsController < ApplicationController

  def index
    @topics = Topic.all.order('id desc')
    @current_user = session[:user_id]
    @topicUserVoteStatus = Topic.new.getUserTopicVoteStatus(@topics, @current_user)
    @all_talks_active = 'active'
  end

  def new
    if Time.now > Time.parse(Setting.submission_end_time)
      respond_to do |format|
        format.html { render template: 'topics/submission_closed' }
      end
    else
      @topic = Topic.new
      @current_speakers = session[:user_id]
      @categories = Category.all
      respond_to do |format|
        format.html { render partial: 'topics/partials/form' }
      end
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @has_voted = @topic.voters.pluck(:name).include?(session[:user_id])
    respond_to do |format|
      format.html { render partial: '/topics/partials/topic' }
    end
  end

  def create
    @topic = Topic.new(params[:topic].permit(:title, :category_id, :description))
    if @topic.save_with_registerer_and_speakers(session[:user_id], params[:speakers])
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
    @topics = Topic.all.order('id desc')
    respond_to do |format|
      format.xls
    end
  end

  def vote_for
    topic = Topic.find(params[:id])
    user = User.find_or_create_by(name: session[:user_id])
    unless topic.voters.include? user
      topic.voters << user
    end
    render nothing: true, status: :created
  end

  def revoke_vote
    topic = Topic.find(params[:id])
    topic_voters = topic.voters
    topic_voters.each { |voter|
      if voter.name == session[:user_id]
        topic_voters.delete(voter)
      end
    }
    render nothing: true, status: :ok
  end

end
