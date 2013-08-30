require 'rake/testtask'
require 'rspec/core/rake_task'
require 'sinatra/activerecord/rake'
$:.unshift File.dirname(__FILE__)
#require 'app/main'
require 'app/blog'

Rake::TestTask.new do |t|
#  t.libs << 'app'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

namespace :spec do
  desc 'Run all rspec tests'
  RSpec::Core::RakeTask.new('all')
end

task :default => [:mytest]

desc 'test for demo_api'
task :mytest do
  ruby 'test/demo_api_test.rb'
end
