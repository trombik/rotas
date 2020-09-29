# frozen_string_literal: true

require "rotas/version"
require "bundler/setup"
require "sinatra/base"

module Rotas
  class Error < StandardError; end

  # The application
  class App < Sinatra::Base
    get "/" do
      "Welcome to my page!"
    end

    post "/" do
      "Hello #{params[:name]}!"
    end
  end
end
