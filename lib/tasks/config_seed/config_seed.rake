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
end