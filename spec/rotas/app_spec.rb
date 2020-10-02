# frozen_string_literal: true

RSpec.describe Rotas::App do
  include Rack::Test::Methods

  let(:app) { Rotas::App }

  describe "/" do
    it "redirects to /projects" do
      get "/"
      expect(last_response.redirection?).to be true
      expect(last_response.headers['Location'].split("/").last).to eq "projects"
    end
  end

  describe "/projects" do
    it "supports gzip" do
      header "Accept-Encoding", "gzip"
      get "/projects"
      expect(last_response.headers['Content-Encoding']).to eq "gzip"
    end
  end

  %w[stable latest].each do |v|
    describe "/project/doesnotexist/esp8266/#{v}" do
      it "returns 404" do
        get "/project/foo/latest"
        expect(last_response.status).to eq 404
      end
    end

    describe "/project/foo/doesnotexist/#{v}" do
      it "returns 404" do
        get "/project/foo/latest"
        expect(last_response.status).to eq 404
      end
    end

    describe "/project/foo/esp8266/#{v}" do
      it "returns 404" do
        get "/project/foo/latest"
        expect(last_response.status).to eq 404
      end
    end
  end

  describe "/project/foo/esp32/doesnotexist" do
    it "returns 404" do
      get "/project/foo/latest"
      expect(last_response.status).to eq 404
    end
  end

  ["1.0.0.bin", "3.0.0.bin"].each do |f|
    describe "/project/foo/esp32/file/#{f}" do
      it "returns file" do
        get "/project/foo/esp32/file/#{f}"
        expect(last_response.status).to eq 200
      end
    end
  end

  describe "/project/:name/:arch/branch/:branch" do
    context "when running version is not valid semver" do
      %w[esp32 esp32s1].each do |a|
        it "returns 403" do
          get "/project/foo/#{a}/branch/stable?v=not.valid"
          expect(last_response.status).to eq 403
        end
      end
    end

    context "when running version is not given" do
      %w[esp32 esp32s1].each do |a|
        it "returns 403" do
          get "/project/foo/#{a}/branch/stable"
          expect(last_response.status).to eq 403
        end
      end
    end

    context "when the branch is stable" do
      context "and running version is older than the stable" do
        %w[esp32 esp32s1].each do |a|
          it "sends the stable version file" do
            get "/project/foo/#{a}/branch/stable?v=1.0.0"
            expect(last_response.status).to eq 200
          end
        end
      end

      context "and running version is the stable" do
        %w[esp32 esp32s1].each do |a|
          it "returns 304" do
            get "/project/foo/#{a}/branch/stable?v=2.0.0"
            expect(last_response.status).to eq 304
          end
        end
      end
      context "and running version is newer than the stable" do
        %w[esp32 esp32s1].each do |a|
          it "returns the stable version file" do
            get "/project/foo/#{a}/branch/stable?v=3.0.0"
            expect(last_response.status).to eq 200
          end
        end
      end
    end

    context "when the branch is latest" do
      context "and running version is older than the latest" do
        %w[esp32 esp32s1].each do |a|
          it "send the latest version file" do
            get "/project/foo/#{a}/branch/latest?v=1.0.0"
            expect(last_response.status).to eq 200
            get "/project/foo/#{a}/branch/latest?v=2.0.0"
            expect(last_response.status).to eq 200
          end
        end
      end

      context "and running version is the latest" do
        %w[esp32 esp32s1].each do |a|
          it "returns 304" do
            get "/project/foo/#{a}/branch/latest?v=3.0.0"
            expect(last_response.status).to eq 304
          end
        end
      end

      context "and running version is newer than the latest" do
        %w[esp32 esp32s1].each do |a|
          it "returns the latest version file" do
            get "/project/foo/#{a}/branch/latest?v=10.0.0"
            expect(last_response.status).to eq 200
          end
        end
      end
    end
  end
end
