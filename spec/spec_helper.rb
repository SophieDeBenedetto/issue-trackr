require 'capybara/rspec'
require 'omniauth'
require 'rails_helper'
require 'capybara/rspec'
require 'webmock/rspec'

require_relative './support/vcr_setup.rb'
# require_relative './support/capybara_setup.rb'
# require_relative './support/billy_setup.rb'

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  :provider => 'github',
  :uid => '123545',
  :info => {email: "sophie@flatironschool.com"}
})


RSpec.configure do |config|
  config.include Capybara::DSL
  # config.include WaitForAjax, type: :feature
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end
  config.before(:each) { ActionMailer::Base.deliveries.clear }      

  SmsSpec.driver = :"twilio-ruby"
  Capybara.javascript_driver = :webkit

  config.use_transactional_fixtures = false

   config.before(:suite) do
     if config.use_transactional_fixtures?
       raise(<<-MSG)
         Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
         (or set it to false) to prevent uncommitted transactions being used in
         JavaScript-dependent specs.

         During testing, the app-under-test that the browser driver connects to
         uses a different database connection to the database connection used by
         the spec. The app's database connection would not be able to access
         uncommitted transaction data setup over the spec's database connection.
       MSG
     end
     DatabaseCleaner.clean_with(:truncation)
   end

   config.before(:each) do
     DatabaseCleaner.strategy = :transaction
   end

   config.before(:each, type: :feature) do
     # :rack_test driver's Rack app under test shares database connection
     # with the specs, so continue to use transaction strategy for speed.
     driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

     if !driver_shares_db_connection_with_specs
       # Driver is probably for an external browser with an app
       # under test that does *not* share a database connection with the
       # specs, so use truncation strategy.
       DatabaseCleaner.strategy = :truncation
     end
   end

   config.before(:each) do
     DatabaseCleaner.start
   end

   config.append_after(:each) do
     DatabaseCleaner.clean
   end


   # config.around :each, :js do |ex|
   #   ex.run_with_retry retry: 3
   # end

   # config.around(:each, type: :feature) do |example|
   #   WebMock.allow_net_connect!
   #   example.run
   #   WebMock.disable_net_connect!(allow_localhost: true)
   # end


  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation

  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end

def sign_in
  visit '/'
  click_link('log in')
end

