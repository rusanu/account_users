$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "account_users/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "account_users"
  s.version     = AccountUsers::VERSION
  s.authors     = ["Remus Rusanu"]
  s.email       = ["contact@rusanu.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of AccountUsers."
  s.description = "TODO: Description of AccountUsers."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "mysql2"
end
