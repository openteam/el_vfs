require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'

  ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

  Dir[Rails.root.join("../support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include Vfs::Engine.routes.url_helpers
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
  end

  Vfs::Engine.load_engine_routes
end

Spork.each_run do
end

