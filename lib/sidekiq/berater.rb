module Sidekiq
  module Berater
    extend self

    LOCK = Mutex.new

    class << self
      @defaults = {
        # redis: Sidekiq.redis_pool,
      }
    end

    def defaults(**opts)
      LOCK.synchronize do
        @defaults.update(**opts)
      end
    end

    def reset
      LOCK.synchronize do
        @defaults = {}
      end
    end
  end
end
