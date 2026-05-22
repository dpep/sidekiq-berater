require_relative "lib/sidekiq/berater/version"

Gem::Specification.new do |s|
  s.name        = "sidekiq-berater"
  s.version     = Sidekiq::Berater::VERSION
  s.authors     = ["Daniel Pepper"]
  s.summary     = "Sidekiq::Berater"
  s.description = <<~DESCRIPTION
    Sidekiq middleware that uses Berater to throttle, rate-limit,
    or load-shed jobs at enqueue and execution time.
  DESCRIPTION
  s.homepage    = "https://github.com/dpep/sidekiq-berater"
  s.license     = "MIT"

  s.files       = Dir.glob("lib/**/*")
  s.test_files  = Dir.glob("spec/**/*_spec.rb")

  s.add_dependency "berater"
  s.add_dependency "sidekiq", ">= 6"

  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end
