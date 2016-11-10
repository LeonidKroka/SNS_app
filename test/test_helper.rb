ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require 'database_cleaner'
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

class ActiveSupport::TestCase
  include Capybara::DSL
  self.use_transactional_tests = true
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
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

  def valid_image
    { image: File.open("#{Rails.root}/test/fixtures/files/some.jpg"),
      user_id: @user.id }
  end
end
