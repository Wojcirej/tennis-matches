require 'spec_config'

RSpec.describe Web::PlayersController, type: :request do
  let(:base_url) { "/players" }

  describe "#GET /players.csv" do
    let(:path) { "#{base_url}.csv" }

    it_behaves_like "endpoint responding with csv content"
  end
end
