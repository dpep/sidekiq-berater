module Sidekiq
  module Middleware
    module Server
      class Berater
        # Install middleware:
        #
        #   Sidekiq.configure_server do |config|
        #     config.server_middleware do |chain|
        #       chain.add Sidekiq::Middleware::Server::Berater
        #     end
        #   end
        def initialize(opts = {})

        end


        def call(worker, *)
          limiter = worker.sidekiq_options_hash["limiter"]
          return yield unless limiter

          limiter.limit do
            yield
          end

          # worker.class.perform_in(delay, *msg['args'])
        end

      end
    end
  end
end
