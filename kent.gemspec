# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kent/version'

Gem::Specification.new do |gem|
  gem.name          = "kent"
  gem.version       = Kent::VERSION
  gem.authors       = ["Ilya Bylich"]
  gem.email         = ["ilya.bylich@productmadness.com"]
  gem.description   = %q{description}
  gem.summary       = %q{sumary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
end
