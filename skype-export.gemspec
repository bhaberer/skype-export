# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skype-export/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '3.1.4'
  spec.name          = 'skype-export'
  spec.version       = SkypeExport::VERSION
  spec.authors       = ['Brian Haberer']
  spec.email         = ['bhaberer@gmail.com']

  spec.summary       = 'Simple gem to export Skype History'
  spec.homepage      = 'https://github.com/bhaberer/skype-export'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = ['export-skype-history']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'

  spec.add_runtime_dependency 'sequel', '~> 5.77'
  spec.add_runtime_dependency 'sqlite3'
end
