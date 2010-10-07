#!/usr/bin/env rake
require 'rake/testtask'
$:.unshift "."
$:.unshift(File.expand_path('lib'))

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
  t.libs << 'test'
  t.ruby_opts << "-rubygems -rtest"
  # t.warning = true
  t.verbose = true
end

task :default => :test