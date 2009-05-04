class TweetTail::TweetPoller
  attr_accessor :query, :latest_results
  
  def initialize(query)
    @query = query
  end
  
  def refresh
    @latest_feed    = JSON.parse(initial_json_data)
    @latest_results = @latest_feed["results"].reverse
    @refresh_url    = @latest_feed["refresh_url"]
  end
  
  def render_latest_results
    @latest_results.inject("") do |output, tweet|
      screen_name = tweet['from_user']
      message     = tweet['text']
      output += "#{screen_name}: #{message}\n"
    end
  end

  protected
  def initial_json_data
    Net::HTTP.get(URI.parse("http://search.twitter.com/search.json?q=#{query}"))
    # open("http://search.twitter.com/search.json?q=#{query}")
  end
end 
