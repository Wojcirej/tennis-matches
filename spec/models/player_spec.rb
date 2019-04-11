# == Schema Information
#
# Table name: players
#
#  id            :uuid             not null, primary key
#  first_name    :string           not null
#  last_name     :string           not null
#  country       :string           not null
#  date_of_birth :date
#  born          :string
#  sex           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_config'

RSpec.describe Player, type: :model do

  describe "columns" do

    it { is_expected.to have_db_column(:first_name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:last_name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:country).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:date_of_birth).of_type(:date) }
    it { is_expected.to have_db_column(:born).of_type(:string) }
    it { is_expected.to have_db_column(:sex).of_type(:string).with_options(null: false) }
  end

  describe "validations" do

    it { is_expected.to validate_presence_of(:first_name).with_message("Please specify player's first name.") }
    it { is_expected.to validate_presence_of(:last_name).with_message("Please specify player's last name.") }
    it { is_expected.to validate_presence_of(:country).with_message("Please specify player's nationality.") }
    it { is_expected.to validate_presence_of(:sex).with_message("Please specify player's sex.") }
    it { is_expected.to validate_inclusion_of(:sex).in_array(["female", "male"]) }
  end

  describe "#full_name" do
    let(:player) { create(:player) }

    it "returns player's first name and last name" do
      expect(player.full_name).to eq("#{player.first_name} #{player.last_name}")
    end
  end

  describe "#full_date_of_birth" do
    let(:player) { create(:player, date_of_birth: Date.new(1987, 4, 19)) }

    it "returns date of birth with name of the month" do
      expect(player.full_date_of_birth).to eq("19 April 1987")
    end
  end

  describe "#age" do

    context "when date of birth set to 19-04-1987" do
      let(:player) { create(:player, date_of_birth: "19-04-1987") }

      context "when called at 07-04-2019" do

        before do
          Timecop.freeze(DateTime.new(2019, 4, 7))
        end

        after do
          Timecop.return
        end

        it "returns 31" do
          expect(player.age).to eq(31)
        end
      end

      context "when called at 20-04-2019" do

        before do
          Timecop.freeze(DateTime.new(2019, 4, 20))
        end

        after do
          Timecop.return
        end

        it "returns 32" do
          expect(player.age).to eq(32)
        end
      end

      context "when called at 19-04-2019" do

        before do
          Timecop.freeze(DateTime.new(2019, 4, 19))
        end

        after do
          Timecop.return
        end

        it "returns 32" do
          expect(player.age).to eq(32)
        end
      end
    end
  end
end
