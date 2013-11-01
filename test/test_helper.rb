require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/setup'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def login_as(user)
	   sign_in(usuarios(user))
  end
  
  def unprotected_attributes(obj)
    attributes = {}
    obj._accessible_attributes[:default].each do |attribute|
      attributes[attribute] = obj.send(attribute) unless attribute.blank?
    end
    attributes
  end

  def sample_file(filename = "rails.png")
    File.new(Rails.root + "test/fixtures/#{filename}")
  end
  
end

class ActionController::TestCase
	include Devise::TestHelpers
end