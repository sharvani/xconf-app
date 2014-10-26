class Setting < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :value, presence: true

  module Type
    SUBMISSION_END_TIME = "Submission end time"
    VOTE_END_TIME = "Vote end time"
  end

  class << self
    def submission_end_time
      submission_end_time = find_by(name: Type::SUBMISSION_END_TIME)
      submission_end_time.present? ? submission_end_time.value : nil
    end

    def vote_end_time
      vote_end_time = find_by(name: Type::VOTE_END_TIME)
      vote_end_time.present? ? vote_end_time.value : nil
    end
  end
end