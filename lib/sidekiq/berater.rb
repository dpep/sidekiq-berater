module Sidekiq
  module Berater
    class << self
      attr_accessor :_default_limits
    end

    self._default_limits = {}

    def self.default_limits(**opts)
      self._default_limits.update(**opts)
    end
  end
end
