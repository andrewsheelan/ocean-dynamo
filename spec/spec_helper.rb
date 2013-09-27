require 'simplecov'
SimpleCov.start do
  add_filter "/vendor/"
  add_filter "spec/dummy/config/initializers/aws.rb"
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }


RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  #config.include Rails.application.routes.url_helpers

  # Make "FactoryGirl" superfluous
  config.include FactoryGirl::Syntax::Methods

  # To clear the fake_dynamo DB before and/or after each run, uncomment as desired:
  config.before(:suite) { `curl -s -X DELETE http://localhost:4567` }
  # config.after(:suite)  { `curl -s -X DELETE http://localhost:4567` }
end
