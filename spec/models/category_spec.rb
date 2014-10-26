require 'rails_helper'

describe Category do
  it 'should validate presence of admin email address' do
    should validate_presence_of :name
    should validate_presence_of :time_in_min
  end
end