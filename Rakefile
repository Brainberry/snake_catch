# encoding: utf-8
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'snake_catch', 'version')

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the snake_catch plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the snake_catch plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Rails SnakeCatch'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "snake_catch"
    gemspec.version = SnakeCatch::Version.dup
    gemspec.summary = "Rails plugin for catch exception and sent it to Snake API"
    gemspec.description = "Send exceptions to Snake server for store"
    gemspec.email = "galeta.igor@gmail.com"
    gemspec.homepage = "http://github.com/Brainberry/snake_catch"
    gemspec.authors = ["Igor Galeta"]
    gemspec.files = FileList["[A-Z]*", "{lib}/**/*"]
    gemspec.rubyforge_project = "snake_catch"
    
    gemspec.add_dependency('curb')
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
