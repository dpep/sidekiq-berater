require "berater"
require "sidekiq"
require "sidekiq/berater"
require "sidekiq/berater/version"
require "sidekiq/berater/worker"
require "sidekiq/middleware/server/berater"

begin
  require "rspec"
  require "sidekiq/berater/rspec"
rescue LoadError
  # ignore
end

# begin
#   require "sidekiq-ent"

#   # ensure Berater plays nice with Sidekiq::Ent limiters
#   unless Sidekiq::Limiter.errors.include? Berater::Overloaded
#     Sidekiq::Limiter.errors << Berater::Overloaded
#   end
# rescue LoadError
#   # ignore
# end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::Server::Berater
  end
end

# require 'sidekiq/job_retry'
# Sidekiq::JobRetry
