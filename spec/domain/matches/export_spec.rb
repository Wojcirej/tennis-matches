require 'spec_config'

RSpec.describe Matches::Export do
  subject { described_class.call(data) }
  let(:data) { create_list(:match, 2) }

  describe "#call" do
    let(:lines) { subject.split("\n") }
    let(:expected_headers) do
      %w(home_player_name away_player_name tournament_name stage date
      home_seed away_seed home_set_1_score home_set_2_score home_set_3_score
      home_set_4_score home_set_5_score away_set_1_score away_set_2_score
      away_set_3_score away_set_4_score away_set_5_score tiebreak_set_1_score
      tiebreak_set_2_score tiebreak_set_3_score tiebreak_set_4_score
      tiebreak_set_5_score).join(",")
    end

    include_examples "csv exporters", "matches"
  end
end
