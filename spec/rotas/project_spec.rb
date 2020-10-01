# frozen_string_literal: true

require_relative "../spec_helper"
require "pathname"
require "rotas/project"

RSpec.describe Rotas::Project do
  let(:project_with_single_arch) do
    Rotas::Project.new(name: "foo", arch:
                                                      ["esp32"], path:
                                                      "./dist", stable:
                                                      "2.0.0")
  end

  describe "#arch" do
    it "returns all arch" do
      expect(project_with_single_arch.arch.length).to eq 1
      expect(project_with_single_arch.arch.key?(:esp32)).to be true
    end
  end
end
