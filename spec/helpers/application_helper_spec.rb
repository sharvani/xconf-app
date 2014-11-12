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

  context 'prevent_submission' do
    it 'should return true if the current time has past the submission end time' do
      Setting.create(name: Setting::Type::SUBMISSION_END_TIME, value: 'Thu Nov 29 14:33:20 IST 2001')

      Timecop.freeze(Time.parse('Thu Nov 29 15:33:20 IST 2001')) do
        expect(prevent_submission).to be_truthy
      end
    end

    it 'should return false if the current time is behind the submission end time' do
      Setting.create(name: Setting::Type::SUBMISSION_END_TIME, value: 'Mon Oct 27 14:33:20 IST 2014')

      Timecop.freeze(Time.parse('Sun Oct 26 14:33:20 IST 2014')) do
        expect(prevent_submission).to be_falsey
      end
    end
  end

  context 'prevent_voting' do
    it 'should return true if the current time has past the vote end time' do
      Setting.create(name: Setting::Type::VOTE_END_TIME, value: 'Thu Nov 29 14:33:20 IST 2001')

      Timecop.freeze(Time.parse('Thu Nov 29 15:33:20 IST 2001')) do
        expect(prevent_vote?).to be_truthy
      end
    end

    it 'should return false if the current time is behind the vote end time' do
      Setting.create(name: Setting::Type::VOTE_END_TIME, value: 'Mon Oct 27 14:33:20 IST 2014')

      Timecop.freeze(Time.parse('Sun Oct 26 14:33:20 IST 2014')) do
        expect(prevent_vote?).to be_falsey
      end
    end
  end
end