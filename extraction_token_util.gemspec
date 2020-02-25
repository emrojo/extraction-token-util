# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'extraction_token_util'
  version = '0.0.3a'
  version = (ENV['TRAVIS_BUILD_NUMBER']).to_s if version.end_with?('a')
  s.version = version
  s.date = '2020-02-22'
  s.summary = %(
    Set of Ruby methods to provide lexical support to common formats in use
    in Extraction Lims
  )
  s.files = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.authors = ['Eduardo Martin Rojo']
  s.require_paths = ['lib']
  s.license = 'MIT'
  s.homepage = 'https://rubygems.org/gems/extraction_token_util'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop', '~> 0.80'
  s.add_development_dependency 'rubocop-rspec'
end
