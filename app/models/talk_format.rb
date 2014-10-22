class TalkFormat < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :time, presence: true
end