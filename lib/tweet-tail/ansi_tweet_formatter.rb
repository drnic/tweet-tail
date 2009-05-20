module TweetTail::AnsiTweetFormatter
  COLORS = { 'black' => 0,
             'red' => 1,
             'green' => 2,
             'yellow' => 3,
             'blue' => 4,
             'magenta' => 5,
             'cyan' => 6,
             'white' => 7 }

  def self.extend_object(obj)
    @@username_color, @@keyword_color, @@url_color = configure_colors
    super
  end
  
  def self.configure_colors
    color_list = (ENV['TWEETTAIL_COLORS'] || "green,cyan,cyan").split(',')
    return COLORS[color_list[0]], COLORS[color_list[1]], COLORS[color_list[2]]
  end

  def format(tweet)
    escaped_message = escape_replys_and_hashtags_in tweet['text']
    escaped_message = escape_urls_in escaped_message
    escaped_user = escape_username tweet['from_user']
    "#{escaped_user}: #{escaped_message}\n"
  end
  
  def escape_replys_and_hashtags_in(text)
    text.gsub(%r{[@#]\w+}, "\e[3#{@@keyword_color}m\\0\e[0m")
  end
  
  def escape_urls_in(text)
    text.gsub(%r{https?://[\w./]+}, "\e[4;3#{@@url_color}m\\0\e[0m")
  end
  
  def escape_username(username)
    "\e[3#{@@username_color}m#{username}\e[0m"
  end
  
  private :escape_replys_and_hashtags_in,
          :escape_urls_in,
          :escape_username
end