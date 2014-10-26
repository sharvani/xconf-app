require 'rails_helper'

describe ApplicationHelper do

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