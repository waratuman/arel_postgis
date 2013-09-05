require 'rake/testtask'
require "bundler/gem_tasks"

task :console do
  exec 'irb -I lib -r rubygems -r arel -r arel/postgis.rb'
end
task :c => :console

desc "Run tests"
Rake::TestTask.new do |test|
  test.libs << 'test'
  test.test_files = Dir['test/**/*_test.rb']
  test.verbose = true
end
