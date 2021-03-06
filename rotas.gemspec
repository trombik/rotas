# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rotas/version"

# there is no point to limit block length in gemspec
# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = "rotas"
  spec.version       = Rotas::VERSION
  spec.authors       = ["Tomoyuki Sakurai"]
  spec.email         = ["y@trombik.org"]

  spec.summary       = "Write a short summary, because RubyGems requires one."
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://github.com/trombik/rotas"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/trombik/rotas"
  spec.metadata["changelog_uri"] = "https://github.com/trombik/rotas/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 2.6"

  spec.add_runtime_dependency "sem_version"
  spec.add_runtime_dependency "sinatra", "~> 2.0.8"
  spec.add_runtime_dependency "sinatra-contrib"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-process"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rerun"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", ">= 0.92.0"
  spec.add_development_dependency "yard"
end
# rubocop:enable Metrics/BlockLength
