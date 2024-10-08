require "berater/rspec"
require "byebug"
require "rspec"
require "simplecov"
require "sidekiq/testing/inline"

SimpleCov.start do
  add_filter "/spec/"
end

if ENV["CI"] == "true" || ENV["CODECOV_TOKEN"]
  require "simplecov_json_formatter"
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
end

# load this gem
gem_name = Dir.glob("*.gemspec")[0].split(".")[0]
require gem_name

RSpec.configure do |config|
  # allow "fit" examples
  config.filter_run_when_matching :focus

  config.mock_with :rspec do |mocks|
    # verify existence of stubbed methods
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    Sidekiq::Worker.clear_all
  end
end

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

Sidekiq::Testing.inline!
