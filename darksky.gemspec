# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "darksky/version"

Gem::Specification.new do |s|
  s.name        = "darksky"
  s.version     = Darksky::VERSION
  s.authors     = ["David Czarnecki"]
  s.email       = ["me@davidczarnecki.com"]
  s.homepage    = "https://github.com/darkskyapp/darksky-ruby"
  s.summary     = %q{Ruby gem for retrieving data from the Dark Sky API}
  s.description = %q{Ruby gem for retrieving data from the Dark Sky API}

  s.rubyforge_project = "darksky"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('typhoeus')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('vcr')
end
