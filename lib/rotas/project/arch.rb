# frozen_string_literal: true

require "pathname"
require "sem_version"
require "rotas/utils"

module Rotas
  class Project
    # A supported arch in a Rotas::Project
    class Arch
      attr_reader :arch, :project, :path

      include Rotas::Utils

      def initialize(args)
        @arch = args[:arch]
        @path = args[:path].is_a?(Pathname) ? args[:path] : Pathname.new(args[:path])
        @project = args[:project]
        @stable_version = args[:stable_version]
      end

      # the latest version for an arch
      #
      # @return [SemVersion]
      def latest_version
        file_to_semver(sorted_files.first)
      end

      # Path to the latest version file
      #
      # @return [Pathname]
      def latest_version_file
        sorted_files.first
      end

      # the stable version for an arch
      #
      # @return [SemVersion]
      def stable_version
        file_to_semver(stable_version_file)
      end

      # Path to the stable version file
      #
      # @return [Pathname]
      def stable_version_file
        return sorted_files.first unless @stable_version

        sorted_files.select { |f| file_to_semver(f) <= SemVersion.new(@stable_version) }.first
      end

      def stable_version_file_content
        stable_version_file.read
      end

      # List of file paths to files for an arch
      #
      # @return [Array<Pathname>]
      def sorted_files
        sort_file_name_by_semver(all_files.select { |f| semver_file?(f) })
      end

      # Specific file
      #
      # @param filename [String] basename of the file
      # @return [Pathname]
      # @raise [Error::FileNotFound] The file does not exist
      #
      # @example
      #   arch.file("1.0.0.bin") #=> #<Pathname:/path/to/1.0.0.bin>
      def file(filename)
        file = sorted_files.select { |f| f.basename.to_s == filename }.first
        raise Error::FileNotFound if file.nil?

        file
      end

      private

      def all_files
        # false means excluding directory
        @path.realpath.children(false).map { |f| @path + f }
      end

      class Error
        class FileNotFound < StandardError
        end
      end
    end
  end
end
