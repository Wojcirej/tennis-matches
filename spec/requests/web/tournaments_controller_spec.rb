require 'spec_config'

RSpec.describe Web::TournamentsController, type: :request do
  let(:base_url) { "/tournaments" }

  describe "#GET /tournaments.csv" do
    let(:path) { "#{base_url}.csv" }

    it_behaves_like "endpoint responding with csv content"
  end
end
