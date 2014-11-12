require 'rails_helper'

describe User do
  it 'should return true if the current user is an admin user' do
    AdminUser.create(name: 'Admin', email: 'admin@admin.com')
    user = User.new(name: 'Admin', email: 'admin@admin.com')

    expect(user.admin?).to be_truthy
  end

  it 'should return false if the current user is not an admin user' do
    user = User.new(name: 'Admin', email: 'admin@admin.com')

    expect(user.admin?).to be_falsey
  end
end
