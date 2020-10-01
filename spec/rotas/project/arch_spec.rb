# frozen_string_literal: true

require_relative "../../spec_helper"
require "pathname"
require "sem_version"
require "rotas/project/arch"

RSpec.describe Rotas::Project::Arch do
  let(:arch) do
    Rotas::Project::Arch.new(
      project: "foo",
      arch: "esp32",
      path: "dist/esp32",
      stable_version: "2.0.0"
    )
  end
  let(:all_files) do
    [
      Pathname.new("2.1.0.bin"),
      Pathname.new("1.0.0.bin"),
      Pathname.new("3.0.0.bin"),
      Pathname.new("2.0.0.bin")
    ]
  end

  describe "#arch" do
    it "returns esp32" do
      expect(arch.arch).to eq "esp32"
    end
  end

  describe "#path" do
    it "returns dist/esp32" do
      expect(arch.path.to_s).to eq "dist/esp32"
    end
  end

  describe "#project" do
    it "returns foo" do
      expect(arch.project).to eq "foo"
    end
  end

  describe "#sorted_files" do
    it "returns a list of sorted files" do
      expect(arch).to receive(:all_files).and_return(all_files)
      expect(arch.sorted_files).to eq [
        Pathname.new("3.0.0.bin"),
        Pathname.new("2.1.0.bin"),
        Pathname.new("2.0.0.bin"),
        Pathname.new("1.0.0.bin")
      ]
    end
  end

  describe "#latest_version_file" do
    it "returns path to the latest version file" do
      expect(arch).to receive(:all_files).and_return(all_files)
      expect(arch.latest_version_file).to eq Pathname.new("3.0.0.bin")
    end
  end

  describe "#latest_version" do
    it "returns the latest version" do
      expect(arch).to receive(:all_files).and_return(all_files)
      expect(arch.latest_version).to eq SemVersion.new("3.0.0")
    end
  end

  describe "#stable_version_file" do
    it "returns path to stable version" do
      expect(arch).to receive(:all_files).and_return(all_files)
      expect(arch.stable_version_file.to_s).to eq "2.0.0.bin"
    end
  end

  describe "#stable_version" do
    it " returns stable version" do
      expect(arch).to receive(:all_files).and_return(all_files)
      expect(arch.stable_version).to eq SemVersion.new("2.0.0")
    end
  end

  describe "stable_version_file_content" do
    it "returns file content of stable version" do
      fd = double(:fd)
      expect(fd).to receive(:read).and_return("content")
      expect(arch).to receive(:stable_version_file).and_return(fd)
      expect(arch.stable_version_file_content).to eq "content"
    end
  end
end
