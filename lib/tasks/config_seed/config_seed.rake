namespace :config_seed do
  desc "add admin users"
  task :add_admin_users => :environment do
    p "Enter the admin email addresses"
    emails = STDIN.gets.chomp.split(',')
    emails.compact.uniq.collect { |email| AdminUser.create(name: email.strip) }
  end
end