# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skype-export/version'

Gem::Specification.new do |spec|
  spec.name          = 'skype-export'
  spec.version       = SkypeExport::VERSION
  spec.authors       = ['Brian Haberer']
  spec.email         = ['bhaberer@gmail.com']

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'TODO: Put your gems website or public repo URL here.'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'nil'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = ['skyp-export']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
  spec.add_runtime_dependency 'sequel', '~> 4.31', '>= 4.31.0'
end
