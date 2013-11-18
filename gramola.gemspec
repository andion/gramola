# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gramola/version'

Gem::Specification.new do |spec|
  spec.name          = "gramola"
  spec.version       = Gramola::VERSION
  spec.authors       = ["Lucas Andión"]
  spec.email         = ["andion@gmail.com"]
  spec.description   = %q{Hassle-free, battery friendly mp3 player for your mac}
  spec.summary       = %q{Gramola is a command-line script to call afplay on your Music collection
under ~/Music from your mac's Terminal}
  spec.homepage      = "https://github.com/andion/gramola"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.executables   = ['gramola']

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
