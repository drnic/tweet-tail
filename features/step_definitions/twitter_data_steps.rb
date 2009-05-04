Given /^twitter has some search results for "([^\"]*)"$/ do |query|
  FakeWeb.register_uri(
    :get,
    "http://search.twitter.com/search.json?q=#{query}",
    :file => File.expand_path(File.dirname(__FILE__) + "/../fixtures/search-#{query}.json"))
end
