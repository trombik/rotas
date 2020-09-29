# frozen_string_literal: true

RSpec.describe Rotas::App do
  include Rack::Test::Methods

  let(:app) { Rotas::App }

  it "returns welcome page" do
    get "/"
    expect(last_response.body).to match(/Welcome/)
  end

  it "greets" do
    post "/", name: "Foo"
    expect(last_response.body).to match(/Hello Foo/)
  end
end
