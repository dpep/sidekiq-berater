module Sidekiq
  module Berater
    module Worker
      def self.included(base)
        base.include(Sidekiq::Worker) unless base < Sidekiq::Worker
        base.extend(ClassMethods)
      end

      module ClassMethods
        def limit(*args, **kwargs)
          raise ArgumentError if args.empty? && kwargs.empty?

          Berater(
            kwargs.delete(:key) || self.to_s,
            *args,
            **Sidekiq::Berater.defaults.merge(**kwargs),
          ).tap do |limiter|
            sidekiq_options limiter: limiter
          end
        end
      end
    end
  end
end
