# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hollaback/version'

Gem::Specification.new do |spec|
  spec.name          = 'hollaback'
  spec.version       = Hollaback::VERSION
  spec.authors       = ['Localytics']
  spec.email         = ['oss@localytics.com']

  spec.summary       = 'Add callbacks to your methods'
  spec.homepage      = 'https://github.com/localytics/hollaback'
  spec.license       = 'MIT'

  files              = `git ls-files -z`.split("\x0")
  spec.files         = files.reject { |f| f.match(%r{^test/}) }

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'rubocop', '~> 0.39'
end
