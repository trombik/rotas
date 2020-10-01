# frozen_string_literal: true

require "sem_version"

module Rotas
  # Helper methods for classes
  module Utils
    def semver_file?(file_path)
      version = file_path.basename.to_s.split(".")[0..-2].join(".")
      valid = SemVersion.valid?(version)
      # XXX SemVersion.valid? returns nil when bogus string is given
      valid.nil? ? false : valid
    end

    def file_to_semver(file)
      SemVersion.new(file.basename.to_s.split(".")[0..-2].join("."))
    end

    def sort_file_name_by_semver(files)
      files.sort do |a, b|
        file_to_semver(b) <=> file_to_semver(a)
      end
    end
  end
end
