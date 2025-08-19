ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    OmniAuth.config.test_mode = true
    def log_in_as(user)
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: user.provider,
        uid: user.uid,
        info: {
          name: user.name,
          email: user.email
        }
      })
      post "/auth/google_oauth2/callback"
    end
  end
end
