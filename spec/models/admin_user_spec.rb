require 'rails_helper'

describe AdminUser do
  it 'should validate presence of admin email address' do
    should validate_presence_of :name
  end
end