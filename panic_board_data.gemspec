# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'panic_board_data/version'

Gem::Specification.new do |spec|
  spec.name          = "panic_board_data"
  spec.version       = PanicBoardData::VERSION
  spec.authors       = ["Darren Cauthon"]
  spec.email         = ["darren@cauthon.com"]
  spec.description   = %q{Export data for Panic Status Board}
  spec.summary       = %q{Export data for Panic Status Board}
  spec.homepage      = "http://www.github.com/darrencauthon/panic_board_data"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "subtle"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "contrast"
end
