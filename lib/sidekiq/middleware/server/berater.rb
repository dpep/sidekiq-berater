module Sidekiq
  module Middleware
    module Server
      class Berater
        def call(worker, *, &block)
          # byebug
          options = worker.sidekiq_options_hash["limiter"]
          return yield unless worker.class.limiter

          worker.class.limiter.limit(&block)
        rescue ::Berater::Overloaded
          byebug
          # worker.class.perform_in(delay, *msg['args'])
        end

      end
    end
  end
end
