ENV["RAILS_ENV"] = "test"

require "bundler/setup"
Bundler.setup

require 'test/unit'
require 'shoulda'
require 'mocha'

require 'trademe'

module Trademe::Testing
  def open_mock(file)
    File.read(File.dirname(__FILE__) + "/mocks/" + file) 
  end
end

class Test::Unit::TestCase
  include Trademe::Testing
end
