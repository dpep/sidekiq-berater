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
