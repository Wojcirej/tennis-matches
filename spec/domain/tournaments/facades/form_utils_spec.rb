require 'spec_config'

def implemented_methods
  %i(tour tournament tournament_categories)
end

RSpec.describe Tournaments::Facades::FormUtils do
  subject { described_class.new(tour) }
  let(:tour) { "WTA" }

  implemented_methods.each do |method|
    it "has '#{method}' method" do
      expect(subject.respond_to?(method)).to be true
    end
  end

  describe "#tournament_categories" do

    context "when tour 'WTA'" do
      let(:expected_categories) { expected_wta_tournament_categories }

      it "returns tournament categories only for WTA tour" do
        expect(subject.tournament_categories).to eq(expected_categories)
      end
    end

    context "when tour 'ATP'" do
      let(:tour) { "ATP" }
      let(:expected_categories) { expected_atp_tournament_categories }

      it "returns tournament categories only for WTA tour" do
        expect(subject.tournament_categories).to eq(expected_categories)
      end
    end

    context "when tour 'ITF'" do
      let(:tour) { "ITF" }
      let(:expected_categories) { expected_itf_tournament_categories }

      it "returns tournament categories only for ITF tour" do
        expect(subject.tournament_categories).to eq(expected_categories)
      end
    end
  end
end
