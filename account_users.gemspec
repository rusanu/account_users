$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "account_users/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "account_users"
  s.version     = AccountUsers::VERSION
  s.authors     = ["Remus Rusanu"]
  s.email       = ["contact@rusanu.com"]
  s.homepage    = "https://github.com/rusanu/account_users"
  s.summary     = "Account and Users (M:N)"
  s.description = "Management of accounts and users, allowing multiple users per account and multiple accounts per user."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency 'active_presenter'

  s.add_development_dependency "mysql2"
end
