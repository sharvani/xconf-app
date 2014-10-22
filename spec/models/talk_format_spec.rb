require 'rails_helper'

describe TalkFormat do
  it 'should validate presence of admin email address' do
    should validate_presence_of :name
    should validate_presence_of :time
  end
end