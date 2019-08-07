require_relative 'lib/minimal_markdown/version'

Gem::Specification.new do |s|
  s.name        = 'minimal_markdown'
  s.version     = MinimalMarkdown::VERSION
  s.summary     = "Minimal markdown renderer"
  s.description = "A lightweight and minimal Ruby implementation of a Markdown renderer, designed with security in mind."
  s.authors     = ["Roger Nesbitt"]
  s.email       = 'roger@seriousorange.com'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage    = 'https://github.com/mogest/minimal_markdown'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.8.0'
end
