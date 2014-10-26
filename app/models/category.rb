class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :time_in_min, presence: true
end