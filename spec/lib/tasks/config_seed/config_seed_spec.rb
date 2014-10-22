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
end