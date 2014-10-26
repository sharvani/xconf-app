require 'rails_helper'

describe ApplicationHelper do

  context 'category_options' do
    it 'should generate options for category' do
      @categories = [
          Category.new(name: 'Talk 1', time_in_min: 30),
          Category.new(name: 'Talk 2', time_in_min: 10),
      ]

      result = category_options(@categories)

      expect(result).to eq(options_for_select([
                                                  ['Talk 1 (30min)', @categories.first.id],
                                                  ['Talk 2 (10min)', @categories.last.id],
                                              ]))
    end
  end

  context 'admin_user' do
    it 'should return true if the given username is an admin in the system' do
      AdminUser.create(name: 'admin@admin.com')

      expect(admin_user('admin@admin.com')).to be_truthy
    end

    it 'should return false if the given username is not an admin in the system' do
      expect(admin_user('admin@admin.com')).to be_falsey
    end
  end
end