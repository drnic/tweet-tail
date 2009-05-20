require 'net/http'
require 'tweet-tail/ansi_tweet_formatter'

class TweetTail::TweetPoller
  attr_accessor :query, :latest_results, :refresh_url
  
  def initialize(query)
    @query       = query
    @refresh_url = nil
  end
  
  def refresh
    unless @refresh_url
      @latest_feed = JSON.parse(initial_json_data)
    else
      @latest_feed = JSON.parse(refresh_json_data)
    end
    @latest_results = @latest_feed["results"].reverse
    @refresh_url    = @latest_feed["refresh_url"]
  end
  
  def render_latest_results
    @latest_results.inject("") do |output, tweet|
      output += format(tweet)
    end
  end

  def format(tweet)
    screen_name = tweet['from_user']
    message     = tweet['text']
    "#{screen_name}: #{message}\n"
  end
  
  protected
  def initial_json_data
    Net::HTTP.get(URI.parse("http://search.twitter.com/search.json?q=#{query}"))
  end

  def refresh_json_data
    Net::HTTP.get(URI.parse("http://search.twitter.com/search.json#{refresh_url}"))
  end
end 
