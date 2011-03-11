Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.6'
  
  s.name        = "trademe"
  s.version     = '0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Oliver Clarke"]
  s.email       = ["ollie@clarketus.net"]
  s.homepage    = "https://github.com/clarketus/trademe"
  s.summary     = "Ruby wrapper for the trademe.co.nz public API"
  s.description = "Ruby wrapper for the trademe.co.nz public API"
  
  s.require_paths = %w[lib]
  s.rdoc_options = ["--charset=UTF-8"]
  
  s.add_dependency "oauth"
  s.add_dependency "yajl-ruby"
  
  s.add_development_dependency('test-unit')
  s.add_development_dependency("shoulda")
  s.add_development_dependency("mocha")
  
  # = MANIFEST =
  s.files = %w[
    CHANGELOG
    Gemfile
    Gemfile.lock
    MIT-LICENSE
    README.rdoc
    Rakefile
    init.rb
    lib/trademe.rb
    lib/trademe/authentication.rb
    lib/trademe/gateway.rb
    lib/trademe/models/authenticated_user.rb
    lib/trademe/models/listing.rb
    lib/trademe/models/user.rb
    test/mocks/bad_response.json
    test/mocks/listing_search.json
    test/test.rb
    test/trademe/authentication_test.rb
    test/trademe/gateway_test.rb
    trademe.gemspec
  ]
  # = MANIFEST =
  
  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /\/*_test\.rb/ }
end
