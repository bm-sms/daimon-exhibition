ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'capybara/poltergeist'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :each do
    DatabaseRewinder.clean
  end

  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
end

Capybara.configure do |config|
  config.javascript_driver = :poltergeist
end
