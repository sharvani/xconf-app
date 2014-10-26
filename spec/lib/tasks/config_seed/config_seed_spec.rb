require 'rails_helper'
require 'rake'

describe "ConfigSeed" do

  before :each do
    Rake.application.rake_require "tasks/config_seed/config_seed"
    Rake::Task.define_task :environment
  end

  context "add_admin_users" do
    before :each do
      Rake::Task['config_seed:add_admin_users'].reenable
    end

    it "should add admin user records to table" do
      allow(STDIN).to receive(:gets).and_return("admin@admin.com, email@email.com", "EXIT")

      Rake.application.invoke_task "config_seed:add_admin_users"

      expect(AdminUser.all.pluck(:name)).to eq(["admin@admin.com", "email@email.com"])
    end

    it "should remove duplicates and add admin user records to table" do
      allow(STDIN).to receive(:gets).and_return("admin@admin.com, admin@admin.com, email@email.com", "EXIT")

      Rake.application.invoke_task "config_seed:add_admin_users"

      expect(AdminUser.all.pluck(:name)).to eq(["admin@admin.com", "email@email.com"])
    end

    it "should ignore empty inputs and add admin user records to table" do
      allow(STDIN).to receive(:gets).and_return("admin@admin.com, , email@email.com", "EXIT")

      Rake.application.invoke_task "config_seed:add_admin_users"

      expect(AdminUser.all.pluck(:name)).to eq(["admin@admin.com", "email@email.com"])
    end
  end

  context "add_talk_formats" do
    before :each do
      Rake::Task['config_seed:add_talk_formats'].reenable
    end

    it "should add the talk name,talk time pair to the talks list, ignoring any empty inputs" do
      allow(STDIN).to receive(:gets).and_return("Talk 1 : 30, , Talk 2 : 10", "EXIT")

      Rake.application.invoke_task "config_seed:add_talk_formats"

      expect(Category.first.name).to eq "Talk 1"
      expect(Category.first.time_in_min).to eq 30
      expect(Category.last.name).to eq "Talk 2"
      expect(Category.last.time_in_min).to eq 10
    end

    it "should not add the talk name,talk time pair if it is a duplicate" do
      allow(STDIN).to receive(:gets).and_return("Talk 1 : 30, Talk 1 : 10", "EXIT")

      Rake.application.invoke_task "config_seed:add_talk_formats"

      expect(Category.all.size).to eq 1
      expect(Category.first.name).to eq "Talk 1"
      expect(Category.first.time_in_min).to eq 30
    end
  end

  context "Configure submission end time" do
    before :each do
      Rake::Task['config_seed:submission_end_time'].reenable
    end

    it "should add the submission end time if not already present" do
      allow(STDIN).to receive(:gets).and_return("Thu Nov 29 14:33:20 IST 2001", "EXIT")

      Rake.application.invoke_task "config_seed:submission_end_time"

      expect(Setting.submission_end_time).to eq "Thu Nov 29 14:33:20 IST 2001"
    end

    it "should replace the already existing submission end time if present" do
      Setting.create(name: Setting::Type::SUBMISSION_END_TIME, value: "Thu Nov 29 11:33:20 IST 2001")
      allow(STDIN).to receive(:gets).and_return("Thu Nov 29 14:33:20 IST 2001", "EXIT")

      Rake.application.invoke_task "config_seed:submission_end_time"

      expect(Setting.submission_end_time).to eq "Thu Nov 29 14:33:20 IST 2001"
    end
  end

  context "Configure vote end time" do
    before :each do
      Rake::Task['config_seed:vote_end_time'].reenable
    end

    it "should add the vote end time if not already present" do
      allow(STDIN).to receive(:gets).and_return("Thu Nov 29 14:33:20 IST 2001", "EXIT")

      Rake.application.invoke_task "config_seed:vote_end_time"

      expect(Setting.vote_end_time).to eq "Thu Nov 29 14:33:20 IST 2001"
    end

    it "should replace the already existing vote end time if present" do
      Setting.create(name: Setting::Type::VOTE_END_TIME, value: "Thu Nov 29 11:33:20 IST 2001")
      allow(STDIN).to receive(:gets).and_return("Thu Nov 29 14:33:20 IST 2001", "EXIT")

      Rake.application.invoke_task "config_seed:vote_end_time"

      expect(Setting.vote_end_time).to eq "Thu Nov 29 14:33:20 IST 2001"
    end
  end
end