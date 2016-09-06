$:.push File.expand_path('../lib', __FILE__)

require 'daimon/exhibition/version'

Gem::Specification.new do |s|
  s.name        = 'daimon-exhibition'
  s.version     = Daimon::Exhibition::VERSION
  s.authors     = ['Ryunosuke Sato']
  s.email       = ['tricknotes.rs@gmail.com']
  s.homepage    = 'https://github.com/bm-sms/daimon-exhibition'
  s.summary     = 'A simple mylist that can contain some products.'
  s.description = 'A simple mylist that can contain some products.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 5.0.0'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_rewinder'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
end
