describe "sidekiq/berater/rspec" do
  describe Sidekiq::Middleware::Server::Berater do
    it "has been loaded into Sidekiq::Testing" do
      expect(
        Sidekiq::Testing.server_middleware.exists?(described_class)
      ).to be true
    end
  end
end
