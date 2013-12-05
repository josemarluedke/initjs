lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'initjs/version'

Gem::Specification.new do |gem|
  gem.name          = "initjs"
  gem.version       = Initjs::VERSION
  gem.authors       = ["Josemar Davi Luedke"]
  gem.email         = ["josemarluedke@gmail.com"]
  gem.homepage      = "http://github.com/josemarluedke/initjs"
  gem.description   = %q{Initjs helps your organize your javascript files using Rails' asset pipeline. Providing a simple and automatic way to execute your javascript for a specific page.}
  gem.summary       = %q{Initjs for your Rails application}
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('rails', '>= 3.1')
  gem.add_dependency 'jquery-rails'

  gem.add_development_dependency 'rspec-rails', '~> 2.14.0'
  gem.add_development_dependency 'generator_spec', '~> 0.9.0'
  gem.add_development_dependency 'capybara', '~> 2.0.2'
  gem.add_development_dependency 'jquery-rails'
  gem.add_development_dependency 'coffee-rails'
  gem.add_development_dependency 'turbolinks'
end
