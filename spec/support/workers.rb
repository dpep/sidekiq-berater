class MockWorker
  include Sidekiq::Worker

  def perform; end
end

class LimitedWorker
  include Sidekiq::Worker

  sidekiq_options limiter: 123
  # sidekiq_options limiter: Berater.new

  def perform; end
end
