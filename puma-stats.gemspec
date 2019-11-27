# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'puma/stats/version'

Gem::Specification.new do |spec|
  spec.authors       = ['Thomas Kishel']
  spec.description   = "A puma plugin to expose Puma's internal statistics"
  spec.homepage      = 'https://github.com/tkishel/puma-stats'
  spec.license       = 'MIT'
  spec.name          = 'puma-stats'
  spec.require_paths = ['lib']
  spec.summary       = spec.description
  spec.version       = Puma::Stats::VERSION

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.add_runtime_dependency 'puma', '>= 3.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
