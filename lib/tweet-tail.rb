$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module TweetTail
  VERSION = '0.0.1'
end

gem 'json'
require "json"

require "open-uri"

require "tweet-tail/tweet_poller"