# frozen_string_literal: true

# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chain_of_responsibility/version"

Gem::Specification.new do |spec|
  spec.name          = "chain_of_responsibility"
  spec.version       = ChainOfResponsibility::VERSION
  spec.authors       = ["KacperPucek"]
  spec.email         = ["kacper.pucek@gmail.com"]

  spec.summary       = "Ruby implementation of Chain of Responsibility pattern."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/KacperPucek/chain_of_responsibility"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sanelint", "~> 1.0"
  spec.add_development_dependency "simplecov", "~> 0.16.1"
end
