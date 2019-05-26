# == Schema Information
#
# Table name: matches
#
#  id                   :uuid             not null, primary key
#  home_player_id       :uuid             not null
#  away_player_id       :uuid             not null
#  tournament_id        :uuid             not null
#  stage                :string           not null
#  date                 :date             not null
#  home_seed            :string
#  away_seed            :string
#  home_set_1_score     :integer
#  home_set_2_score     :integer
#  home_set_3_score     :integer
#  home_set_4_score     :integer
#  home_set_5_score     :integer
#  away_set_1_score     :integer
#  away_set_2_score     :integer
#  away_set_3_score     :integer
#  away_set_4_score     :integer
#  away_set_5_score     :integer
#  tiebreak_set_1_score :string
#  tiebreak_set_2_score :string
#  tiebreak_set_3_score :string
#  tiebreak_set_4_score :string
#  tiebreak_set_5_score :string
#  retirement           :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'spec_config'

RSpec.describe Match, type: :model do
  subject { create(:match) }

  it { is_expected.to belong_to(:home_player).class_name('Player') }
  it { is_expected.to belong_to(:away_player).class_name('Player') }
  it { is_expected.to belong_to(:tournament) }

  it { is_expected.to have_db_column(:home_player_id).of_type(:uuid).with_options(null: false) }
  it { is_expected.to have_db_column(:away_player_id).of_type(:uuid).with_options(null: false) }
  it { is_expected.to have_db_column(:tournament_id).of_type(:uuid).with_options(null: false) }
  it { is_expected.to have_db_column(:stage).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:date).of_type(:date).with_options(null: false) }
  it { is_expected.to have_db_column(:home_seed).of_type(:string) }
  it { is_expected.to have_db_column(:away_seed).of_type(:string) }
  it { is_expected.to have_db_column(:home_set_1_score).of_type(:integer) }
  it { is_expected.to have_db_column(:home_set_2_score).of_type(:integer) }
  it { is_expected.to have_db_column(:home_set_3_score).of_type(:integer) }
  it { is_expected.to have_db_column(:home_set_4_score).of_type(:integer) }
  it { is_expected.to have_db_column(:home_set_5_score).of_type(:integer) }
  it { is_expected.to have_db_column(:away_set_1_score).of_type(:integer) }
  it { is_expected.to have_db_column(:away_set_2_score).of_type(:integer) }
  it { is_expected.to have_db_column(:away_set_3_score).of_type(:integer) }
  it { is_expected.to have_db_column(:away_set_4_score).of_type(:integer) }
  it { is_expected.to have_db_column(:away_set_5_score).of_type(:integer) }
  it { is_expected.to have_db_column(:tiebreak_set_1_score).of_type(:string) }
  it { is_expected.to have_db_column(:tiebreak_set_2_score).of_type(:string) }
  it { is_expected.to have_db_column(:tiebreak_set_3_score).of_type(:string) }
  it { is_expected.to have_db_column(:tiebreak_set_4_score).of_type(:string) }
  it { is_expected.to have_db_column(:tiebreak_set_5_score).of_type(:string) }
  it { is_expected.to have_db_column(:retirement).of_type(:boolean).with_options(default: false) }

  it { is_expected.to validate_presence_of(:home_player_id).with_message("Please specify participant of the match.") }
  it { is_expected.to validate_presence_of(:away_player_id).with_message("Please specify participant of the match.") }
  it { is_expected.to validate_presence_of(:tournament_id).with_message("Please specify tournament at which match has been played.") }
  it { is_expected.to validate_presence_of(:stage).with_message("Please specify stage of tournament.") }
  it { is_expected.to validate_presence_of(:date).with_message("Please specify date of the match.") }
  it { is_expected.to validate_inclusion_of(:stage).in_array(Tournaments::Enums::TournamentStages.values) }
  it { is_expected.to validate_numericality_of(:home_set_1_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:home_set_2_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:home_set_3_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:home_set_4_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:home_set_5_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:away_set_1_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:away_set_2_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:away_set_3_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:away_set_4_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }
  it { is_expected.to validate_numericality_of(:away_set_5_score).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(7) }

  context "when retirement = 'false'" do
    let(:match) { create(:match, retirement: false) }

    it { expect(match).to validate_presence_of(:home_set_1_score).with_message("Set 1 score for #{match.home_player.full_name} is missing.") }
    it { expect(match).to validate_presence_of(:home_set_2_score).with_message("Set 2 score for #{match.home_player.full_name} is missing.") }
    it { expect(match).to validate_presence_of(:away_set_1_score).with_message("Set 1 score for #{match.away_player.full_name} is missing.") }
    it { expect(match).to validate_presence_of(:away_set_2_score).with_message("Set 2 score for #{match.away_player.full_name} is missing.") }
  end

  describe "#brief_summary" do
    let(:match) { create(:match) }

    it "returns summary of the match in format: [<tournament name> <year> <stage>] [<home player seed>] <home player full name> v. [<away player seed>] <away player full name>" do
      expect(match.brief_summary).to eq("[#{match.tournament.name} #{match.date.year} #{match.stage}] [#{match.home_seed}] #{match.home_player.full_name} v. [#{match.away_seed}] #{match.away_player.full_name}")
    end

    context "when blank home or away seed" do
      let(:match) { create(:match, home_seed: nil, away_seed: nil) }

      it "returns summary of the match in format: [<tournament name> <year> <stage>] <home player full name> v. <away player full name>" do
        expect(match.brief_summary).to eq("[#{match.tournament.name} #{match.date.year} #{match.stage}] #{match.home_player.full_name} v. #{match.away_player.full_name}")
      end
    end
  end
end
