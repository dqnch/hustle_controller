$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'hustle_controller/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'hustle_controller'
  s.version     = HustleController::VERSION
  s.authors     = ['kawamura.hryk']
  s.email       = ['kawamura.hryk@gmail.com']
  s.homepage    = 'https://github.com/dqnch/hustle_controller'
  s.summary     = 'HustleController may extend your RESTful controllers.'
  s.description = 'HustleController may extend your RESTful controllers.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1'
  s.add_dependency 'ransack'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
end
