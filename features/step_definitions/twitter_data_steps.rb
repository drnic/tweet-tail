Given /^twitter has some search results for "([^\"]*)"$/ do |query|
  FakeWeb.register_uri(
    :get,
    "http://search.twitter.com/search.json?q=#{query}",
    :file => File.expand_path(File.dirname(__FILE__) + "/../fixtures/search-#{query}.json"))
  
  since = "1682666650"
  FakeWeb.register_uri(
    :get,
    "http://search.twitter.com/search.json?since_id=#{since}&q=#{query}",
    :file => File.expand_path(File.dirname(__FILE__) + "/../fixtures/search-#{query}-since-#{since}.json"))
end
