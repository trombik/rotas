# frozen_string_literal: true

require "bundler/setup"
require "sinatra"
require "sinatra/base"
require "sinatra/config_file"
require "sem_version"
require "pathname"

require "rotas/version"
require "rotas/project"

module Rotas
  # The application
  class App < Sinatra::Base
    configure :development do
      require "sinatra/reloader"
      register Sinatra::Reloader
      after_reload do
        puts "#{self} reloaded"
      end
    end

    register Sinatra::ConfigFile
    config_yml = Pathname.new(__FILE__).parent.parent.parent / "config.yml"
    raise "#{config_yml} cannot be found" unless config_yml.file?

    config_file config_yml

    def projects
      settings.projects.map { |p| Rotas::Project.new(p.transform_keys(&:to_sym)) }
    end

    get "/" do
      redirect to("/projects")
    end

    get "/projects" do
      erb "projects/list".to_sym, locals: { projects: projects }
    end

    get "/project/:name" do
      project = projects.select { |p| p.name == params[:name] }.first
      begin
        raise Error::ProjectNotFound if project.nil?

        erb "project/index".to_sym, locals: { project: project }
      rescue Error::ProjectNotFound
        status 404
        erb :E404
      end
    end

    get "/project/:name/:arch/branch/:branch" do
      project = projects.select { |p| p.name == params[:name] }.first
      branch = params[:branch]
      v = params["v"]
      arch = project.arch[params[:arch].to_sym]
      begin
        raise Error::ProjectNotFound if project.nil?
        raise Error::MissingRunningVersion if v.nil? || v.empty?
        raise Error::NotValidSemver if !SemVersion.valid?(v) || SemVersion.valid?(v).nil?
        raise Error::ArchNotFound unless arch.is_a?(Rotas::Project::Arch)

        running_version = SemVersion.new(v)
        case branch
        when "stable"
          arch.stable_version == running_version ? (status 304) : (send_file arch.stable_version_file)
        when "latest"
          arch.latest_version == running_version ? (status 304) : (send_file arch.latest_version_file)
        else
          raise Error::BranchNotFound
        end
      rescue Error::NotValidSemver, Error::MissingRunningVersion
        status 403
        erb :E403
      rescue Error::ProjectNotFound, Error::BranchNotFound, Error::ArchNotFound
        status 404
        erb :E404
      end
    end

    get "/project/:name/:arch/file/:filename" do
      project = projects.select { |p| p.name == params[:name] }.first
      begin
        raise Error::ProjectNotFound if projects.nil?

        send_file project.arch[params[:arch].to_sym].file(params[:filename]).realpath
      rescue Rotas::Project::Arch::Error::FileNotFound, Error::ProjectNotFound
        status 404
        erb :E404
      end
    end

    class Error
      # the version in the query parameter is not valid semver
      class NotValidSemver < StandardError; end

      # when no running version is given
      class MissingRunningVersion < StandardError; end

      # when project cannot be found
      class ProjectNotFound < StandardError; end

      # when given branch is unknown
      class BranchNotFound < StandardError; end

      # when given branch is unknown
      class ArchNotFound < StandardError; end
    end
  end
end
