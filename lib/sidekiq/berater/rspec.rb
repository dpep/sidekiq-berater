require "rspec/core"
require "sidekiq/testing"

RSpec.configure do |config|
  config.before do
  	Sidekiq::Testing.server_middleware do |chain|
  	  chain.add Sidekiq::Middleware::Server::Berater
  	end

    Sidekiq::Berater.reset
  end
end
