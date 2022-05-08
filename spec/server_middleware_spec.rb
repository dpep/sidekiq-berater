describe Sidekiq::Middleware::Server::Berater do
  before do
    Sidekiq::Testing.server_middleware do |chain|
      chain.add described_class
    end
  end

  it "calls the middleware" do 
    # expect_any_instance_of(described_class).to receive(:call).and_call_original
  end

  context "with an unlimited worker" do 
    it "works as expected" do
      expect_any_instance_of(MockWorker).to receive(:perform)
      MockWorker.perform_async
    end
  end
end
