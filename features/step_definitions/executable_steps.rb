When /^I run executable internally with arguments "(.*)"/ do |arguments|
  # a version of the bin/tweet-tail file
  require 'rubygems'
  require File.expand_path(File.dirname(__FILE__) + "/../../lib/tweet-tail")
  require "tweet-tail/cli"
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    TweetTail::CLI.execute(@stdout_io = StringIO.new, arguments.split(" "))
    @stdout_io.rewind
    File.open(@stdout, "w") do |file|
      file << @stdout_io.read
    end
  end
end

