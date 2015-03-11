# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'



Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!



RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

def sign_in
  @user1 = User.create(
        first_name: 'Jeff',
        last_name: 'Austin',
        email: 'jeff@austin.com',
        password: 'mandolin',
        password_confirmation: 'mandolin'
        )
        visit '/'
        click_on "Sign In"
        fill_in "Email", with: '@user1.email'
        fill_in "Password", with: '@user1.password'
        within("form") { click_on 'Sign In'}
end
