Gem::Specification.new do |s|
  s.name = %q{extraction_token_util}
  s.version = "0.0.1"
  s.date = %q{2020-02-22}
  s.summary = %q{Set of Ruby methods to provide lexical support to common formats in use in Extraction Lims}
  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.authors = ["Eduardo Martin Rojo"]
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec"
end
