require 'spec_config'

RSpec.describe Matches::Facades::FormUtils do
  subject { described_class.new }

  describe "#initialize" do

    context "when no match object present" do

      it "initializes 'match' with new, not persisted instance of Match class" do
        expect(described_class.new.match.persisted?).to be false
      end

      it "initializes 'match' with not decorated Match object" do
        expect(described_class.new.match).to be_kind_of(Match)
      end
    end

    context "when match object present" do
      let(:match) { create(:match) }

      it "initializes 'match' with persisted passed Match object" do
        expect(described_class.new(match).match.persisted?).to be true
      end

      it "initializes 'match' with decorated Match object" do
        expect(described_class.new(match).match).to be_kind_of(Matches::Decorators::Details)
      end
    end
  end

  describe "#players" do
    let!(:players) { create_list(:player, 2) }

    it "returns array containing as much arrays as amount of players in database" do
      expect(subject.players.size).to eq(2)
    end

    it "returns pairs of player's full name and ID for each player" do
      subject.players.each_with_index do |player, index|
        expect(player[0]).to eq(Player.all[index].full_name)
        expect(player[1]).to eq(Player.all[index].id)
      end
    end
  end

  describe "#tournaments" do
    let!(:tournaments) { create_list(:tournament, 2) }

    it "returns array containing as much arrays as amount of tournaments in database" do
      expect(subject.tournaments.size).to eq(2)
    end

    it "returns pairs of tournaments's name and ID for each tournament" do
      subject.tournaments.each_with_index do |tournament, index|
        expect(tournament[0]).to eq(Tournament.all[index].name)
        expect(tournament[1]).to eq(Tournament.all[index].id)
      end
    end
  end

  describe "#stages" do

    it "returns array containing as much arrays as available stages" do
      expect(subject.stages.size).to eq(11)
    end

    it "returns pairs of names of tournament stages and it's valid symbols" do
      returned_stage_names = subject.stages.map(&:first)
      returned_valid_symbols = subject.stages.map(&:last)
      expected_stage_names = Tournaments::Enums::TournamentStages.keys.map { |key| key.to_s.humanize }
      expect(returned_stage_names).to match_array(expected_stage_names)
      expect(returned_valid_symbols).to match_array(Tournaments::Enums::TournamentStages.values)
    end
  end

  describe "#seeds" do
    let(:expected_array) { (1..32).to_a + ["LL", "WC", "PR", "Q"] }
    it "returns array of seeds from 1-32 range and symbols for wild card, protected ranking, lucky loser and qualifier" do
      expect(subject.seeds).to eq(expected_array)
    end
  end

  describe "#date" do

    context "when no match object present" do

      before do
        Timecop.freeze(Date.today)
      end

      after do
        Timecop.return
      end

      it "returns 'today' date" do
        expect(subject.date).to eq(Date.today)
      end
    end

    context "when match object present" do
      let(:match) { create(:match) }

      it "returns date of the match" do
        expect(described_class.new(match).date).to eq(match.date)
      end
    end
  end

  describe "#lead_text" do

    context "when no match object present" do

      it "returns nil" do
        expect(subject.lead_text).to be_nil
      end
    end

    context "when match object present" do
      let(:match) { create(:match, stage: "F") }

      it "returns summary of the match without information about participants" do
        expect(described_class.new(match).lead_text).to eq("#{match.tournament.name} #{match.date.year} Final")
      end
    end
  end
end
