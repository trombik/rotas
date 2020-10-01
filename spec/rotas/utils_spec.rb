# frozen_string_literal: true

require_relative "../spec_helper"
require "rotas/utils"
require "pathname"

class Foo
  include Rotas::Utils
end

RSpec.describe Rotas::Utils do
  let(:obj) { Foo.new }
  let(:all_files) do
    [
      Pathname.new("1.0.0.bin"),
      Pathname.new("2.0.0.bin"),
      Pathname.new("2.1.0.bin"),
      Pathname.new("3.0.0.bin")
    ]
  end

  describe "#sort_file_name_by_semver" do
    it "returns sorted file names" do
      expect(obj.sort_file_name_by_semver(all_files).first).to eq Pathname.new("3.0.0.bin")
      expect(obj.sort_file_name_by_semver(all_files).last).to eq Pathname.new("1.0.0.bin")
    end
  end

  describe "#file_to_semver" do
    it "returns SemVersion 1.0.0" do
      expect(obj.file_to_semver(Pathname.new("/path/to/1.0.0.bin"))).to eq SemVersion.new("1.0.0")
    end
  end

  describe "#semver_file?" do
    context "with valid semver file name" do
      it "returns true" do
        expect(obj.semver_file?(Pathname.new("/path/to/1.0.1.bin"))).to eq true
      end
    end

    context "with invalid semver file name" do
      it "returns false" do
        expect(obj.semver_file?(Pathname.new("/path/to/not.valid.bin"))).to eq false
        expect(obj.semver_file?(Pathname.new("/path/to/a.1.0.bin"))).to eq false
      end
    end
  end
end
