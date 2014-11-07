#!/usr/bin/env ruby
require 'fileutils'
require 'csv'
require ::File.expand_path('../../config/environment', __FILE__)

def csv_rows
  @csv_rows ||= read_from_csv
end

def read_from_csv
  rows = []
  file = File.read(ARGF.filename)
  @csv_file = CSV.parse(file, headers: true)
  @csv_file.each do |row|
    rows << row
  end
  rows
end

def as_hash(row)
  row.to_hash.inject({}) do |memo, key_value|
    key, value = key_value
    memo[key.gsub(" ", "_").downcase.to_sym] = value
    memo
  end
end

csv_rows.map do |csv_row|
  csv_attributes = as_hash(csv_row)
  category = Category.find_by(name: csv_attributes[:category])
  topic = Topic.create(title: csv_attributes[:title], description: csv_attributes[:description], category: category)

  registerer = User.find_or_create_by(name: csv_attributes[:username], email: csv_attributes[:username])
  registerer.registered_topics << topic
  topic.speakers << registerer

  if csv_attributes[:pair].present?
    pair = User.find_or_create_by(name: csv_attributes[:pair])
    topic.speakers << pair
  end
end

