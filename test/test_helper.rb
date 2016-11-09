ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"

class ActiveSupport::TestCase
  self.use_transactional_tests = true
end

module UserTestHelper
  def valid_user
    { name: "Exemple",
      surname: "Exemple",
      gender: "Male",
      email: "true_mail@example.com",
      password: "True0pass",
      password_confirmation: "True0pass"}
  end
end
