# require File.dirname(__FILE__) + "/../../lib/tweet-tail"

gem 'cucumber'
require 'cucumber'
gem 'rspec'
require 'spec'

gem "fakeweb"
require "fakeweb"

Before do
  FakeWeb.clean_registry
  FakeWeb.allow_net_connect = false
end
