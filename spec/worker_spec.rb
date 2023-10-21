describe Sidekiq::Berater::Worker do
  describe ".limit" do
    it "initializes a limiter" do
      limiter = MockWorker.limit(1)
      expect(limiter).to be_a Berater::Limiter
      expect(limiter.capacity).to be 1
    end

    it "saves the limiter in the worker" do
      limiter = MockWorker.limit(1)

      expect(MockWorker.get_sidekiq_options["limiter"]).to be limiter
    end

    it "uses the worker class as the default key" do
      limiter = MockWorker.limit(1)
      expect(limiter.key).to eq "MockWorker"
    end

    it "accepts a custom key" do
      limiter = MockWorker.limit(1, key: "key")
      expect(limiter.key).to eq "key"
    end

    context "with default limits" do
      before do
        Sidekiq::Berater.defaults(timeout: 30)
      end

      it "creates a limiter with the defaults" do
        limiter = MockWorker.limit(1)
        expect(limiter.timeout).to be 30
      end
    end
  end
end
