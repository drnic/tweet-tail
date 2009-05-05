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


Then /^I should see some twitter messages$/ do
  actual_output = File.read(@stdout)
  # puts actual_output # UNCOMMENT this to see what the current live data looks like
  lines = actual_output.split("\n")
  lines.length.should_not == 0
  lines.each do |line|
    line.should =~ /^[\w_]+:\s.+$/
  end
end