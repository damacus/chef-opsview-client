require 'chefspec'
require 'chefspec/berkshelf'
require 'webmock'
require 'webmock/rspec/matchers'

WebMock.disable_net_connect!(allow_localhost: true)

CHEFSPEC_RUNNER = if defined?(ChefSpec::SoloRunner)
                    ChefSpec::SoloRunner
                  else
                    ChefSpec::Runner
                  end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.formatter = :documentation
  config.include WebMock::API
  config.include WebMock::Matchers

  # Specify the Chef log_level (default: :warn)
  # config.log_level = :info
end

at_exit { ChefSpec::Coverage.report! }
WebMock::AssertionFailure.error_class = RSpec::Expectations::ExpectationNotMetError
