require 'rake'
require 'rake/testtask'
require "bundler/gem_tasks"

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs << ['lib', 'spec']
end

task :spec => :test
task :default => :spec
