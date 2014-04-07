# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/slow_log/version'

Gem::Specification.new do |spec|

  spec.name          = 'rack-slow-log'
  spec.version       = Rack::SlowLog::VERSION
  spec.authors       = ['Adrian Gomez']
  spec.email         = ['adrian.gomez@moove-it.com']
  spec.summary       = %q{Slow request logger for rack applications.}
  spec.description   = <<-DESCRIPTION
    Allows for setting the maximum request time before it get logged also provides a custom
    log to data relevant to the slow request and can even provide a different log for each slow
    request for easy debugging.
  DESCRIPTION
  spec.homepage      = 'https://github.com/Moove-it/rack-slow-log'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('{lib}/**/*')
  spec.test_files    = Dir.glob('{spec}/**/*')
  spec.require_paths = %w(lib)

  spec.add_dependency 'rack'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'fakefs'

end