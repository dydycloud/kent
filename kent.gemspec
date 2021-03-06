# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "kent"
  gem.version       = "1.0.1"
  gem.authors       = ["Ilya Bylich"]
  gem.email         = ["ibylich@gmail.com"]
  gem.description   = %q{description}
  gem.summary       = %q{sumary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "rails"
  gem.add_development_dependency "resque"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "redcarpet" if RUBY_PLATFORM != "java"
  gem.add_runtime_dependency "render_anywhere"
  gem.add_runtime_dependency "uuid"
  gem.add_runtime_dependency "redis"
end
