require File.dirname(__FILE__) + '/test_helper.rb'

class TestTweetFormatter < Test::Unit::TestCase
  def setup
    @formatter = Object.new.extend(TweetTail::AnsiTweetFormatter)
  end

  def test_should_configure_colors_upon_module_inclusion
    TweetTail::AnsiTweetFormatter.expects(:configure_colors)
    Object.new.extend(TweetTail::AnsiTweetFormatter)
  end
  
  def test_configure_colors_should_use_default_colors_when_environment_variable_not_specified
    ENV['TWEETTAIL_COLORS'] = nil

    username_color, keyword_color, url_color = TweetTail::AnsiTweetFormatter.configure_colors

    assert_equal 2, username_color
    assert_equal 6, keyword_color
    assert_equal 6, url_color
  end
  
  def test_configure_colors_should_set_colors_according_to_environment_variable
    ENV['TWEETTAIL_COLORS'] = "blue,red,yellow"

    username_color, keyword_color, url_color = TweetTail::AnsiTweetFormatter.configure_colors

    assert_equal 4, username_color
    assert_equal 1, keyword_color
    assert_equal 3, url_color
  end
  
  def test_should_escape_username_on_basic_tweet
    assert_equal "\e[32mbob\e[0m: Basic tweet\n", @formatter.format('from_user' => 'bob',
                                                                    'text'      => 'Basic tweet')
  end
  
  def test_should_escape_links_when_at_the_beginning
    assert_match %r{\e\[4;36mhttp://example.com\e\[0m}, @formatter.format('text' => 'http://example.com is my favorite site')
  end
  
  def test_should_escape_links_when_at_the_end
    assert_match %r{\e\[4;36mhttp://example.com\e\[0m}, @formatter.format('text' => 'My favorite site is http://example.com')
  end
  
  def test_should_escape_links_when_https_is_used
    assert_match %r{\e\[4;36mhttps://secure.example.com\e\[0m}, @formatter.format('text' => 'My favorite site is https://secure.example.com')
  end
  
  def test_should_escape_hashtags_when_at_the_beginning
    assert_match %r{\e\[36m#rubyconf\e\[0m}, @formatter.format('text' => '#rubyconf bound')
  end
  
  def test_should_escape_hashtags_when_at_the_end
    assert_match %r{\e\[36m#jaoo\e\[0m}, @formatter.format('text' => 'Hanging at #jaoo')
  end
  
  def test_should_escape_hashtags_when_followed_by_punctuation
    assert_match %r{\e\[36m#jaoo\e\[0m}, @formatter.format('text' => 'Hanging at #jaoo.')
  end

  def test_should_escape_replies_when_at_the_beginning
    assert_match %r{\e\[36m@reply\e\[0m}, @formatter.format('text' => '@reply at beginning')
  end
  
  def test_should_escape_replies_when_at_the_end
    assert_match %r{\e\[36m@end\e\[0m}, @formatter.format('text' => 'reply at @end')
  end
  
  def test_should_escape_replies_when_followed_by_punctuation
    assert_match %r{\e\[36m@sentence\e\[0m}, @formatter.format('text' => 'End of @sentence.')
  end
end
