require "berater"
require "sidekiq"
require "sidekiq/berater/version"
require "sidekiq/middleware/server/berater"

begin
  require "sidekiq-ent"

  unless Sidekiq::Limiter.errors.include? Berater::Overloaded
    Sidekiq::Limiter.errors << Berater::Overloaded
  end
rescue LoadError
  # ignore
end

# require 'sidekiq/job_retry'
# Sidekiq::JobRetry
