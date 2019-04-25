# == Schema Information
#
# Table name: tournaments
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  country    :string           not null
#  city       :string           not null
#  category   :string           not null
#  tour       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_config'

RSpec.describe Tournament, type: :model do

  it { is_expected.to have_many(:matches) }

  it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:country).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:city).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:category).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:tour).of_type(:string).with_options(null: false) }

  it { is_expected.to validate_presence_of(:name).with_message("Please specify name of the tournament.") }
  it { is_expected.to validate_presence_of(:country).with_message("Please specify host country of the tournament.") }
  it { is_expected.to validate_presence_of(:city).with_message("Please specify host city of the tournament.") }
  it { is_expected.to validate_presence_of(:category).with_message("Please select tournament's category.") }
  it { is_expected.to validate_presence_of(:tour).with_message("Please select tour.") }
  it { is_expected.to validate_inclusion_of(:tour).in_array(Enums::Tours.values) }

  context "when tour 'ATP'" do
    let(:tournament) { create(:tournament, :atp) }

    it { expect(tournament).to validate_inclusion_of(:category).in_array(Enums::AtpTournamentCategories.values).with_message("Please select correct tournament category.") }
  end

  context "when tour 'WTA'" do
    let(:tournament) { create(:tournament, :wta) }

    it { expect(tournament).to validate_inclusion_of(:category).in_array(Enums::WtaTournamentCategories.values).with_message("Please select correct tournament category.") }
  end

  context "when tour 'ITF'" do
    let(:tournament) { create(:tournament, :itf) }

    it { expect(tournament).to validate_inclusion_of(:category).in_array(Enums::ItfTournamentCategories.values).with_message("Please select correct tournament category.") }
  end
end
