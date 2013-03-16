# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongobox/version'

Gem::Specification.new do |spec|
  spec.name          = "mongobox"
  spec.version       = Mongobox::VERSION
  spec.authors       = ["zeroed"]
  spec.email         = ["foo@foobar.com"]
  spec.description   = %q{Mongo and Mongolab}
  spec.summary       = %q{Yet another gem for Mongo and Mongolab}
  spec.homepage      = "https://github.com/zeroed/mongobox"
  spec.license       = "GPL-3"

  spec.add_dependency = "rspec"
  spec.add_dependency = "mongo"
  spec.add_dependency = "bson"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
