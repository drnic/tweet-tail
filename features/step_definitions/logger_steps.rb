When /^I dump stdout$/ do
  dump(File.exists?(@stdout) ? File.read(@stdout) : @stdout)
end
