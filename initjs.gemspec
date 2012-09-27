# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'initjs/version'

Gem::Specification.new do |gem|
  gem.name          = "initjs"
  gem.version       = Initjs::VERSION
  gem.authors       = ["Josemar Davi Luedke"]
  gem.email         = ["josemarluedke@gmail.com"]
  gem.description   = %q{Init.js for Rails and Backbone.js}
  gem.summary       = %q{Init.js}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
