$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "camaleon_download/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "camaleon_download"
  s.version     = CamaleonDownload::VERSION
  s.authors     = ["Anderson Rocha (MAX)"]
  s.email       = ["andersonrocha@maxfs.com"]
  s.homepage    = ""
  s.summary     = ": Summary of CamaleonDownload."
  s.description = ": Description of CamaleonDownload."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"

  s.add_development_dependency "sqlite3"
end
