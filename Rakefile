require 'rubygems' unless ENV['NO_RUBYGEMS']
%w[rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/tweet-tail'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('tweettail', TweetTail::VERSION) do |p|
  p.developer('Dr Nic', 'drnicwilliams@gmail.com')
  p.changes        = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.rubyforge_name = 'drnicutilities'
  p.extra_deps = [
    ['json']
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"],
    ['fakeweb', '>= 1.2.2'],
    ['mocha', '>= 0.9.5'],
    ['cucumber', '>= 0.3.2'],
    ['rspec', '>= 1.2.5']
  ]
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
task :default => [:features]
