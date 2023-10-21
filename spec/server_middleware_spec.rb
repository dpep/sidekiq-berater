describe Sidekiq::Middleware::Server::Berater do
  let(:instance) { described_class.new }
  let(:worker) { MockWorker.new }

  before do
    allow(described_class).to receive(:new).and_return(instance)
    allow(MockWorker).to receive(:new).and_return(worker)
  end

  it "calls the middleware" do
    expect(instance).to receive(:call)
    MockWorker.perform_async
  end

  context "when worker has a limiter" do
    let(:limiter) { Berater::Unlimiter.new }

    before { MockWorker.sidekiq_options(limiter: limiter) }

    it "calls the limiter" do
      expect(limiter).to receive(:limit)
      MockWorker.perform_async
    end

    context "when overloaded" do
      let(:limiter) { Berater::Inhibitor.new }

      it "is overloaded" do
        expect(worker).not_to receive(:perform)

        expect {
          MockWorker.perform_async
        }.to be_overloaded
      end
    end
  end
end
