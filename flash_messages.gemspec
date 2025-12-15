# flash_messages.gemspec

require_relative "lib/flash_messages/version"

Gem::Specification.new do |spec|
  spec.name        = "flash_messages"
  spec.version     = FlashMessages::VERSION
  spec.authors     = ["Your Name"]
  spec.email       = ["your.email@example.com"]
  spec.homepage    = "https://github.com/yourusername/flash_messages"
  spec.summary     = "Beautiful animated flash messages for Rails 8"
  spec.description = "A complete flash message system for Rails 8 with Stimulus, Turbo Streams support, and Tailwind CSS styling. Features auto-dismiss, pause on hover, multiple message types, and clean helper methods."
  spec.license     = "MIT"
  
  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yourusername/flash_messages"
  spec.metadata["changelog_uri"]   = "https://github.com/yourusername/flash_messages/blob/main/CHANGELOG.md"
  
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  end
  
  spec.require_paths = ["lib"]
  
  # Dependencies
  spec.add_dependency "rails", ">= 8.0.0"
  
  # Development dependencies
  spec.add_development_dependency "rspec-rails", "~> 6.0"
end
