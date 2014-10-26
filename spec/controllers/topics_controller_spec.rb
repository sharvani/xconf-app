require 'rails_helper'

describe TopicsController do

  context 'new' do
    it 'should render the submission closed page if the current time has passed the submission time' do
      Setting.create(name: Setting::Type::SUBMISSION_END_TIME, value: 'Thu Nov 29 14:33:20 IST 2001')

      Timecop.freeze(Time.parse('Thu Nov 29 15:33:20 IST 2001')) do
        get :new
        expect(response).to render_template 'topics/submission_closed'
      end
    end
  end

  it 'should render the topic submission form if the current time is within the submission time' do
    Setting.create(name: Setting::Type::SUBMISSION_END_TIME, value: 'Thu Nov 29 14:33:20 IST 2001')

    Timecop.freeze(Time.parse('Wed Nov 28 15:33:20 IST 2001')) do
      get :new
      expect(response).to render_template 'topics/partials/_form'
    end
  end

end