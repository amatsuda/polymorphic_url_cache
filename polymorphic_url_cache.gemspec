# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polymorphic_url_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "polymorphic_url_cache"
  spec.version       = PolymorphicUrlCache::VERSION
  spec.authors       = ["Akira Matsuda"]
  spec.email         = ["ronnie@dio.jp"]
  spec.summary       = 'A Rails plugin that aggressively caches the polymorphic url_for results'
  spec.description   = "This plugin might speed up your Rails app's slowest part, or might just break your app"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '< 2.9'
  spec.add_development_dependency 'wrong'
  spec.add_development_dependency 'sqlite3'
end
