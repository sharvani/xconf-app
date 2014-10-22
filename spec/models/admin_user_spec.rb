require 'rails_helper'

describe AdminUser do
  it 'should validate presence of admin email address' do
    should validate_presence_of :name
    should validate_uniqueness_of :name
  end
end