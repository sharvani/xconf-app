namespace :config_seed do
  desc "add admin users"
  task :add_admin_users => :environment do
    p "Enter the admin email addresses"
    emails = STDIN.gets.chomp.split(',')
    emails.compact.uniq.collect { |email| AdminUser.create(name: email.strip) }
  end

  task :add_talk_formats => :environment do
    p "Enter the talk format list as a name and time(in minutes) pair <talk_name:talk_time>"
    talks = STDIN.gets.chomp.split(',')
    talks.compact.uniq.collect do |talk|
      talk_name, talk_time = talk.split(':')
      Category.create(name: talk_name.strip, time_in_min: talk_time.to_i)
    end
  end

  desc "configure submission end time"
  task :submission_end_time => :environment do
    p "Enter the submission end time in the format <Thu Nov 29 10:00:00 IST 2001>"
    submission_end_time = Setting.find_by(name: Setting::Type::SUBMISSION_END_TIME)
    submission_end_time.destroy! if submission_end_time.present?
    Setting.create(name: Setting::Type::SUBMISSION_END_TIME, value: STDIN.gets.strip)
  end

  desc "configure vote end time"
  task :vote_end_time => :environment do
    p "Enter the vote end time in the format <Thu Nov 29 10:00:00 IST 2001>"
    submission_end_time = Setting.find_by(name: Setting::Type::VOTE_END_TIME)
    submission_end_time.destroy! if submission_end_time.present?
    Setting.create(name: Setting::Type::VOTE_END_TIME, value: STDIN.gets.strip)
  end
end