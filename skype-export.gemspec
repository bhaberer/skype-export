# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skype-export/version'

Gem::Specification.new do |spec|
  spec.name          = 'skype-export'
  spec.version       = SkypeExport::VERSION
  spec.authors       = ['Brian Haberer']
  spec.email         = ['bhaberer@gmail.com']

  spec.summary       = %q{Simple gem to export Skype History}
  spec.homepage      = 'https://github.com/bhaberer/skype-export'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = ['export-skype-history']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'

  spec.add_runtime_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
  spec.add_runtime_dependency 'sequel', '~> 4.31', '>= 4.31.0'
end
