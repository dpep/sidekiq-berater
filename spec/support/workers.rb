class SidekiqWorker
  include Sidekiq::Worker

  def perform; end
end


class MockWorker
  include Sidekiq::Berater::Worker

  def perform; end
end

RSpec.configure do |config|
  config.before(:each) do |example|
    def worker
      @worker ||= MockWorker.new
    end unless respond_to?(:worker)

    allow(MockWorker).to receive(:new).and_return(worker)
  end
end
