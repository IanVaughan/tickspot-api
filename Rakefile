require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'
# require './lib/tickspot.rb'

desc 'Test, build and install the gem'
task :default => [:spec, :install]

RSpec::Core::RakeTask.new(:spec)

desc 'Build and install the gem'
task :install do
#   gemspec_path = Dir['*.gemspec'].first
#   spec = eval(File.read(gemspec_path))

#   result = `gem build #{gemspec_path} 2>&1`
#   if result =~ /Successfully built/
#     system "gem uninstall -I #{spec.name} 2>&1"
#     system "gem install #{spec.file_name} --no-rdoc --no-ri 2>&1"
#   else
#     raise result
#   end
end

# require 'hoe'

# Hoe.new('tickspot-ruby', Tickspot::VERSION) do |p|
#   p.rubyforge_name = 'tickspot-ruby' # if different than lowercase project name
#   p.developer('Brian Cooke', 'bcooke@roobasoft.com')
# end

# desc "Run specifications"
# Spec::Rake::SpecTask.new('spec') do |t|
#   t.spec_opts = ["--format", "specdoc", "--colour"]
#   t.spec_files = './spec/**/*_spec.rb'
# end

# Rake::TestTask.new(:spec) do |t|
#   t.pattern = 'spec/*_spec.rb'
# end

# namespace :spec do
#   desc "Run specs with RCov" RSpec::Core::RakeTask.new('rcov') do |t|
#     t.pattern = 'spec/**/*_spec.rb'
#     t.rcov = true
#     t.rcov_opts = ['--exclude', '\/Library\/Ruby']
#   end
# end

# desc 'Take the version in the gemspec, create a git tag and send the gem to rubygems'
# task :release do
#   gemspec_path = Dir['*.gemspec'].first
#   spec = eval(File.read(gemspec_path))

#   system "git tag -f -a v#{spec.version} -m 'Version #{spec.version}'"
#   system "git push --tags"
#   system "gem push #{spec.file_name}"
# end

