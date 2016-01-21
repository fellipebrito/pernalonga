# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pernalonga/version'

Gem::Specification.new do |spec|
  spec.name          = 'pernalonga'
  spec.version       = Pernalonga::VERSION
  spec.authors       = ['Fellipe Brito']
  spec.email         = ['fellipe@devlandia.net']

  spec.summary       = 'Provide a wrapper to Rabbit+Bunny enqueuement system.'
  spec.description   = 'Provide a wrapper to Rabbit+Bunny enqueuement system.'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.8'
  spec.add_development_dependency 'rubocop', '~> 0.36.0'
  spec.add_development_dependency 'simplecov', '~> 0.11.1'

  spec.add_runtime_dependency 'dotenv', '2.1.0'
  spec.add_runtime_dependency 'bunny', '2.2.2'
end
