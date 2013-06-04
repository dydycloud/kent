require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'redcarpet'
require 'yard'
require 'yard/rake/yardoc_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
end
