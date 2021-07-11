# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hollaback/version'

Gem::Specification.new do |spec|
  spec.name          = 'hollaback'
  spec.version       = Hollaback::VERSION
  spec.authors       = ['Kevin Newton']
  spec.email         = ['kddnewton@gmail.com']

  spec.summary       = 'Add callbacks to your methods'
  spec.homepage      = 'https://github.com/kddnewton/hollaback'
  spec.license       = 'MIT'

  files              = `git ls-files -z`.split("\x0")
  spec.files         = files.reject { |f| f.match(%r{^test/}) }

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.12'
  spec.add_development_dependency 'simplecov', '~> 0.14'
end
