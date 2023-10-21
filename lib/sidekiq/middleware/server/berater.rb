module Sidekiq
  module Middleware
    module Server
      class Berater
        def call(worker, *, &block)
          limiter = worker.sidekiq_options_hash["limiter"]
          return yield unless limiter&.is_a?(::Berater::Limiter)

          limiter.limit(&block)
        rescue ::Berater::Overloaded
          raise Sidekiq::Limiter::OverLimit if Sidekiq.ent?

          raise
          # worker.class.perform_in(delay, *msg['args'])
        end
      end
    end
  end
end
