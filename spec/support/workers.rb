class MockWorker
  include Sidekiq::Worker

  def perform; end
end

class LimitedWorker
  include Sidekiq::Worker

  # limiter = Berater::Unlimiter.new
  # sidekiq_options limiter: Berater.new

  def perform; end
end

RSpec.configure do |config|
  config.before(:each) do
    # for all workers, clear limiter
    MockWorker.limiter = nil
  end
end
