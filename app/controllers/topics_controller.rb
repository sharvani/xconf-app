require 'csv'
class TopicsController < ApplicationController

  def index
    @topics = Topic.all.order('category_id, id')
    @topicUserVoteStatus = Topic.new.getUserTopicVoteStatus(@topics, current_user)
    @all_talks_active = 'active'
  end

  def new
    if Time.now > Time.parse(Setting.submission_end_time)
      respond_to do |format|
        format.html { render template: 'topics/submission_closed' }
      end
    else
      @topic = Topic.new
      @current_speakers = current_user.name
      @categories = Category.all
      respond_to do |format|
        format.html { render partial: 'topics/partials/form' }
      end
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @has_voted = @topic.voters.include?(current_user)
    respond_to do |format|
      format.html { render partial: '/topics/partials/topic' }
    end
  end

  def create
    @topic = Topic.new(params[:topic].permit(:title, :category_id, :description))
    if @topic.save_with_registerer_and_speakers(current_user, params[:speakers])
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
    @categories = Category.all
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

  def vote_for
    unless Time.now > Time.parse(Setting.vote_end_time)
      topic = Topic.find(params[:id])
      unless topic.voters.include? current_user
        topic.voters << current_user
      end
      render nothing: true, status: :created
    end
  end

  def revoke_vote
    topic = Topic.find(params[:id])
    topic_voters = topic.voters
    topic_voters.each { |voter|
      if voter == current_user
        topic_voters.delete(voter)
      end
    }
    render nothing: true, status: :ok
  end

  def topics_list
    if current_user.admin?
      respond_to do |format|
        format.csv do
          set_headers_for_csv_response
          self.response_body = csv_stream
        end
      end
    end
  end

  private

  def set_headers_for_csv_response
    headers["Content-Type"] = "text/csv"
    headers["Content-disposition"] = 'attachment; filename="topics.csv"'
  end

  def csv_stream
    Enumerator.new do |csv_rows|
      csv_headers = ["Title", "Type", "Description", "Registerer", "Speakers", "Voted By", "No of Votes"]
      csv_rows << CSV::Row.new(csv_headers, csv_headers, true)

      topics = Topic.all
      topics.each do |topic|
        csv_rows << CSV::Row.new(csv_headers, [topic.title, topic.category.name, topic.description,topic.registerer.name, convert_array_to_string(topic.speakers),convert_array_to_string(topic.voters.uniq), topic.voters.uniq.length])
      end
    end
  end

  def convert_array_to_string array
    array.map { |x| x.name }.join(', ')
  end
end