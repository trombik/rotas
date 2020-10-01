# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "Run rubocop"
task "rubocop" do
  sh "rubocop"
end

desc "Run yamllint"
task "yamllint" do
  sh "yamllint -s -c .yamllint.yml ."
end

desc "Run markdownlint"
task "markdownlint" do
  sh "node node_modules/markdownlint-cli/markdownlint.js -c .markdownlint.yml -i .markdownlintignore ."
end

desc "Generate docs"
task "docs" do
  sh "yard -o docs"
end

task default: [:rubocop, :yamllint, :markdownlint, :spec]
