lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "trademe"
  s.version     = '0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Oliver Clarke"]
  s.email       = ["ollie@clarketus.net"]
  s.homepage    = "https://github.com/clarketus/trademe"
  s.summary     = "Ruby wrapper for the trademe.co.nz public API"
  s.description = "Ruby wrapper for the trademe.co.nz public API"
  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency "oauth"
  s.add_dependency "yajl-ruby"
  
  s.files        = Dir.glob("{lib,test}/**/*") + %w(init.rb Rakefile README.rdoc MIT-LICENSE CHANGELOG Gemfile Gemfile.lock trademe.gemspec)
end