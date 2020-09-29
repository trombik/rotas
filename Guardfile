# frozen_string_literal: true

# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end

markdownlint_command = "node_modules/markdownlint-cli/markdownlint.js"
guard "process",
      command: ["node", markdownlint_command.to_s, "-c", ".markdownlint.yml", "-i", ".markdownlintignore", "."],
      name: "markdownlint" do
  watch(/\.md$/)
end

# vim: ft=ruby
