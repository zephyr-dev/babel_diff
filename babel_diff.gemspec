# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'babel_diff/version'

Gem::Specification.new do |spec|
  spec.name          = "babel_diff"
  spec.version       = BabelDiff::VERSION
  spec.authors       = ["Ryan McGarvey", "Noah Gordon"]
  spec.email         = ["ryan@gust.com", "noah@gust.com", "devs@gust.com"]
  spec.summary       = %q{A logger for updates and additions to locale yaml files.}
  spec.homepage      = "https://github.com/zephyr-dev/babel_diff"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   << "babel_diff" << "babel_import"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
