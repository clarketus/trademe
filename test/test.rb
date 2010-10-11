require "rubygems"
require "bundler/setup"

require 'trademe'
require 'test/unit'

Bundler.require(:default)
Bundler.require(:test)

module Trademe::Testing
  module Helpers
    def open_mock(file)
      File.read(File.dirname(__FILE__) + "/mocks/" + file) 
    end
  end
  
  include Helpers
end

class Test::Unit::TestCase
  include Trademe::Testing
end