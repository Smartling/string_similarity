# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'string_similarity/version'

Gem::Specification.new do |spec|
  spec.name          = "string_similarity"
  spec.version       = StringSimilarity::VERSION
  spec.authors       = ["Nathanael Burt"]
  spec.email         = ["nathanael.burt@gmail.com"]
  spec.summary       = "Gem to find a percentage similarity between two strings"
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.3.0"
end
