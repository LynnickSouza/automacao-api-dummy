# frozen_string_literal: true
require 'json_matchers/rspec'
require 'faker'
require 'httparty'
require 'allure-rspec'
require 'pry'
require 'require_all'
require 'dotenv/load'

require_all 'spec/services'
JsonMatchers.schema_root = 'spec/fixtures/schemas'


RSpec.configure do |config|
  
  config.expect_with :rspec do |expectations|
  
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.formatter = AllureRspecFormatter
end

AllureRspec.configure do |config|
  config.results_directory = 'reports/allure-results'
  config.clean_results_directory = true
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)
end
