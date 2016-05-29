require 'rails_helper'
require 'vcr'

VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.filter_sensitive_data('<GITHUB_TOKEN>') { ENV['GITHUB_TOKEN'] }
  c.filter_sensitive_data('<GITHUB_SECRET>') { ENV['GITHUB_SECRET'] }
  c.filter_sensitive_data('<GITHUB_KEY') { ENV['GITHUB_KEY'] }
end
