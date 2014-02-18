# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unzipper/version'

Gem::Specification.new do |spec|
  spec.name          = 'unzipper'
  spec.version       = Unzipper::VERSION
  spec.authors       = ['Mark McEahern', 'Jim Remsik']
  spec.email         = ['mark@adorable.io', 'jim@adorable.io']
  spec.description   = %q{unzipper unzips to S3}
  spec.summary       = %q{unzipper unzips to S3}
  spec.homepage      = 'http://github.com/adorableio/unzipper'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
