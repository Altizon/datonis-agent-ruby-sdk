# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edge/version'

Gem::Specification.new do |spec|
  spec.name          = "edge"
  spec.version       = Edge::VERSION
  spec.authors       = ["Rajesh Jangam"]
  spec.email         = ["rajesh@altizon.com"]
  spec.summary       = "Gem that allows to communicate and send endpoint data to the Datonis Platform"
  spec.description   = "Gem that allows to communicate and send endpoint data to the Datonis Platform"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = %w(README.md) + Dir.glob('lib/**/*.rb')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
