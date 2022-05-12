module Sidekiq
  module Worker
    module ClassMethods
      def self.extended(base)
        base.sidekiq_class_attribute :limiter
        base.extend(Sidekiq::Berater::Worker::ClassMethods)
      end
    end
  end

  module Berater
    module Worker
      module ClassMethods
        def limit(*args, **kwargs)
          raise ArgumentError if args.empty? && kwargs.empty?

          self.limiter = Berater(
            kwargs.delete(:key) || self.to_s, 
            *args,
            **Sidekiq::Berater.default_limits.merge(**kwargs),
          )
        end
      end
    end
  end
end

# Sidekiq::Worker.prepend(Sidekiq::Berater::Worker)
# puts "prepended"
