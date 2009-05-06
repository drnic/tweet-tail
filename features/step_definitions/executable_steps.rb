# a version of the bin/tweet-tail file
When /^I run executable internally with arguments "([^\"]*)"$/ do |args|
  require 'rubygems'
  require File.dirname(__FILE__) + "/../../lib/tweet-tail"
  require "tweet-tail/cli"
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    TweetTail::CLI.execute(@stdout_io = StringIO.new, args.split(" "))
    @stdout_io.rewind
    File.open(@stdout, "w") { |f| f << @stdout_io.read }
  end
end

When /^I run executable internally with arguments "([^\"]*)" and wait (\d+) sleep cycles? and quit$/ do |args, cycles|
  hijack_sleep(cycles.to_i)
  When %Q{I run executable internally with arguments "#{args}"}
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