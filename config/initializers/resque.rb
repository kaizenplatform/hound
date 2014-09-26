require 'resque/server'
require 'resque-retry'
require 'resque-sentry'
require 'resque/failure/redis'

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  return false if ENV['BASIC_AUTH_USER'].blank? || ENV['BASIC_AUTH_PASSWORD'].blank?
  [user, password] == [ENV['BASIC_AUTH_USER'], ENV['BASIC_AUTH_PASSWORD']]
end

Resque::Failure::Sentry.logger = 'resque'

Resque::Failure::MultipleWithRetrySuppression.classes = [
  Resque::Failure::Redis,
  Resque::Failure::Sentry
]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression
