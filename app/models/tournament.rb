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

class Tournament < ApplicationRecord
  has_many :matches
  validates :name, presence: { message: "Please specify name of the tournament." }
  validates :country, presence: { message: "Please specify host country of the tournament." }
  validates :city, presence: { message: "Please specify host city of the tournament." }
  validates :category, presence: { message: "Please select tournament's category." }
  validates :tour, presence: { message: "Please select tour."}
  validates_inclusion_of :tour, in: Tournaments::Enums::Tours.values
  validates_inclusion_of :category, in: Tournaments::Enums::WtaTournamentCategories.values, message: "Please select correct tournament category.", if: :wta_tournament?
  validates_inclusion_of :category, in: Tournaments::Enums::AtpTournamentCategories.values, message: "Please select correct tournament category.", if: :atp_tournament?
  validates_inclusion_of :category, in: Tournaments::Enums::ItfTournamentCategories.values, message: "Please select correct tournament category.", if: :itf_tournament?

  scope :itf_tournaments, -> { where(tour: Tournaments::Enums::Tours.itf) }
  scope :atp_tournaments, -> { where(tour: Tournaments::Enums::Tours.atp) }
  scope :wta_tournaments, -> { where(tour: Tournaments::Enums::Tours.wta) }

  def itf_tournament?
    tour == Tournaments::Enums::Tours.itf
  end

  def wta_tournament?
    tour == Tournaments::Enums::Tours.wta
  end

  def atp_tournament?
    tour == Tournaments::Enums::Tours.atp
  end
end
