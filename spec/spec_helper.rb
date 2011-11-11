require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'shoulda/matchers'
  require 'fabrication'

  SPEC_ROOT = Rails.root.join('..').to_s

  Dir["#{SPEC_ROOT}/support/**/*.rb"].each {|f| require f}
  Dir["#{SPEC_ROOT}/fabricators/**/*.rb"].each {|f| require f}

  RSpec.configure do |config|
    config.include Vfs::Engine.routes.url_helpers
    config.mock_with :rspec
    config.use_transactional_fixtures = true
  end

  Vfs::Engine.load_engine_routes
end

Spork.each_run do
end

