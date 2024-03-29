$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'el_vfs/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'el_vfs'
  s.version     = ElVfs::VERSION
  s.authors     = ['Dmitry Lihachev', 'Evgeny Lapin']
  s.email       = ['mail@openteam.ru']
  s.homepage    = 'http://github.com/openteam/el_vfs'
  s.summary     = 'Summary of ElVfs.'
  s.description = 'Description of ElVfs.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'ancestry'
  s.add_dependency 'configliere'
  s.add_dependency 'default_value_for'
  s.add_dependency 'dragonfly'
  s.add_dependency 'rails', '~> 3.1.1'

  s.add_development_dependency 'fabrication'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-spork'
  s.add_development_dependency 'libnotify'
  s.add_development_dependency 'rb-inotify'
  s.add_development_dependency 'rspec-rails', '~> 2.6.0'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'spork', '~> 0.9.0.rc9'
  s.add_development_dependency 'sqlite3'
end
