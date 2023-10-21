describe "sidekiq/berater/rspec" do
  describe Sidekiq::Berater do
    describe ".defaults" do
      subject { described_class.defaults }

      it "takes inputs" do
        described_class.defaults(abc: 123)

        is_expected.to include(abc: 123)
      end

      it "resets between tests" do
        is_expected.to be_empty
      end
    end
  end

  describe Sidekiq::Middleware::Server::Berater do
    it "has been loaded into Sidekiq::Testing" do
      expect(
        Sidekiq::Testing.server_middleware.exists?(described_class)
      ).to be true
    end
  end
end
