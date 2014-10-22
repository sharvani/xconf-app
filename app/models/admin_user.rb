class AdminUser < ActiveRecord::Base
  validates :name, presence: true
end