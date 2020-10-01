# frozen_string_literal: true

require "sem_version"
require "rotas/project/arch"

module Rotas
  # Rotas::Project represents a project
  class Project
    attr_reader :name, :stable_version, :arch

    def initialize(arg)
      @name = arg[:name]
      @path = arg[:path].is_a?(Pathname) ? arg[:path] : Pathname.new(arg[:path])
      @stable_version = arg[:stable_version]
      @arch = {}
      arg[:arch].each do |a|
        @arch[a.to_sym] = Rotas::Project::Arch.new(
          arch: a, path: @path.realpath + a, project: @name,
          stable_version: @stable_version
        )
      end
    end

    def path
      @path.realpath
    end
  end
end
