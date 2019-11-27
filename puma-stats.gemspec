# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'puma/stats/version'

Gem::Specification.new do |spec|
  spec.authors       = ['Tom Kishel']
  spec.description   = "A puma plugin to expose Puma's internal statistics"
  spec.email         = 'tom.kishel@puppet.com'
  spec.homepage      = 'https://github.com/tkishel/puma-stats'
  spec.license       = 'MIT'
  spec.name          = 'puma-stats'
  spec.require_paths = ['lib']
  spec.summary       = "Expose Puma's internal statistics"
  spec.version       = Puma::Stats::VERSION

  files              = %w[CHANGELOG.md LICENSE README.md Rakefile lib]
  spec.files         = `git ls-files -z #{files.join(' ')}`.split("\0")

  spec.add_runtime_dependency 'puma', '~> 3.0'

  spec.add_development_dependency 'bundler',  '~> 0'
  spec.add_development_dependency 'minitest', '~> 0'
  spec.add_development_dependency 'rake',     '~> 0'
  spec.add_development_dependency 'rubocop',  '~> 0'
end
