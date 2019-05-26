require 'spec_config'

MatchParticipantsTestingClass = Struct.new(:home_player_id, :away_player_id) do
  include ActiveModel::Validations

  validates_with MatchParticipantsValidator
end

RSpec.describe MatchParticipantsValidator do
  subject { MatchParticipantsTestingClass.new(home_player, away_player) }

  describe "#valid?" do

    context "when both players are the same" do
      let(:player) { create(:player) }
      let(:home_player) { player.id }
      let(:away_player) { player.id }

      it "return false" do
        expect(subject.valid?).to be false
      end

      it "adds error message under 'base' key" do
        subject.valid?
        expect(subject.errors[:base]).to include("Match participants must be different!")
      end
    end

    context "when players are different" do
      let(:home_player) { create(:player).id }
      let(:away_player) { create(:player).id }

      it "returns true" do
        expect(subject.valid?).to be true
      end

      it "doesn't add any messages under 'base' key" do
        subject.valid?
        expect(subject.errors[:base]).to be_blank
      end
    end
  end
end
