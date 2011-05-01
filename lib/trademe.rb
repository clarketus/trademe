require 'net/http'
require 'cgi'
require 'time' # needed in 1.9.2-p180

require 'yajl'
require 'oauth'

module Trademe
  VERSION = "0.2.0"
end

require "trademe/authentication"
require "trademe/my_trademe"
require "trademe/gateway"
