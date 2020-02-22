Gem::Specification.new do |s|
  s.name = %q{extraction_token_util}
  s.version = "0.0.2"
  s.version = "#{s.version}-alpha-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']
  s.date = %q{2020-02-22}
  s.summary = %q{Set of Ruby methods to provide lexical support to common formats in use in Extraction Lims}
  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.authors = ["Eduardo Martin Rojo"]
  s.require_paths = ["lib"]
  s.license = "MIT"
  s.homepage = "https://rubygems.org/gems/extraction_token_util"
  s.add_development_dependency "rspec", '>= 3'
end
