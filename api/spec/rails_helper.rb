require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'mongoid-rspec'
require 'shoulda/matchers'
require 'simplecov'
require 'simplecov-cobertura'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.swagger_dry_run = false
  config.include Mongoid::Matchers, type: :model
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_model
  end
end

SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
SimpleCov.start do
  add_filter '/spec/'
  add_filter 'app/services/video_processor.rb'
  add_filter 'app/services/video_upload.rb'
end