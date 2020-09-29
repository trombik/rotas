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

task default: [:rubocop, :yamllint, :spec]
