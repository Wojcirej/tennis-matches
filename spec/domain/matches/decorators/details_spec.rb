require 'spec_config'

RSpec.describe Matches::Decorators::Details do
  subject { described_class.new(match) }

  describe "#winner_player" do

    context "when home player has won in two sets in BO3 format" do
      let(:match) { create(:match, :home_two_zero_winner) }

      it "returns associated home player object" do
        expect(subject.winner_player).to eq(match.home_player)
      end
    end

    context "when away player has won in two sets in BO3 format" do
      let(:match) { create(:match, :away_two_zero_winner) }

      it "returns associated home player object" do
        expect(subject.winner_player).to eq(match.away_player)
      end
    end
  end

  describe "#loser_player" do

    context "when home player has lost in two sets in BO3 format" do
      let(:match) { create(:match, :away_two_zero_winner) }

      it "returns associated home player object" do
        expect(subject.loser_player).to eq(match.home_player)
      end
    end

    context "when away player has lost in two sets in BO3 format" do
      let(:match) { create(:match, :home_two_zero_winner) }

      it "returns associated home player object" do
        expect(subject.loser_player).to eq(match.away_player)
      end
    end
  end

  describe "#scoreline" do
    let(:match) { create(:match, :away_two_zero_winner) }

    it "returns scoreline of the match in format <winner>-<loser> for each played set" do
      expect(subject.scoreline).to eq("7-5 6-3")
    end

    context "when tie break was contested in any of sets" do
      let(:match) { create(:match, :home_two_zero_winner_with_tie_break) }

      it "includes smaller number of tie break score in parenthesis" do
        expect(subject.scoreline).to eq("7-6(6) 6-3")
      end
    end
  end

  describe "#summary_without_participants" do
    let(:match) { create(:match, :away_two_zero_winner, stage: "F") }

    it "returns tournament name, year and humanized stage without players names" do
      expect(subject.summary_without_participants).to eq("#{match.tournament.name} #{match.date.year} Final")
    end
  end
end
