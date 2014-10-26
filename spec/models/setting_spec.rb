require 'rails_helper'

describe Setting do
  it 'should validate presence of configuration name and value' do
    should validate_presence_of :name
    should validate_presence_of :value
  end
end