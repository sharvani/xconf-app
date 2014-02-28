class Topic < ActiveRecord::Base
  validates :title, :description, presence: true
end
