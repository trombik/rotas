# frozen_string_literal: true

require "rotas/version"
require "bundler/setup"
require "sinatra/base"
require "rotas/app"

module Rotas
  class Error < StandardError; end
end
