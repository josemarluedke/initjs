# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'initjs/version'

Gem::Specification.new do |gem|
  gem.name          = "initjs"
  gem.version       = Initjs::VERSION
  gem.authors       = ["Josemar Davi Luedke"]
  gem.email         = ["josemarluedke@gmail.com"]
  gem.description   = %q{Init.js is a Ruby Gem that helps run your javascript only in a page that its necessary}
  gem.summary       = %q{Init.js for your Rails application}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('rails', '~> 3.1')
end
