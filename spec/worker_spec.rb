describe Sidekiq::Berater::Worker do 
  describe ".limit" do
    it "initializes a limiter" do 
      limiter = MockWorker.limit(1)
      expect(limiter).to be_a Berater::Limiter
      expect(limiter).to be_a Berater::StaticLimiter
      expect(limiter.capacity).to be 1
    end

    it "uses the worker class as the default key" do 
      limiter = MockWorker.limit(1)
      expect(limiter.key).to eq "MockWorker"
    end

    it "accepts a custom key" do 
      limiter = MockWorker.limit(1, key: "key")
      expect(limiter.key).to eq "key"
    end

    context "with default_limits" do 
      before do 
        Sidekiq::Berater.default_limits(timeout: 30)
      end

      it "creates a limiter with the defaults" do 
        limiter = MockWorker.limit(1)
        expect(limiter.timeout).to be 30
      end
    end
  end

  describe ".limiter" do 
    subject { MockWorker.limiter }

    it { is_expected.to be nil }

    it "updates with .limit" do 
      limiter = MockWorker.limit(1)
      is_expected.to be limiter
    end

    it "can be set directly" do 
      MockWorker.limiter = :abc
      is_expected.to eq :abc
    end
  end
end
