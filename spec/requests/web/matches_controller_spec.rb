require 'spec_config'

RSpec.describe Web::MatchesController, type: :request do
  let(:base_url) { "/matches" }

  describe "#GET /matches.csv" do
    let(:path) { "#{base_url}.csv" }

    it_behaves_like "endpoint responding with csv content"
  end
end
