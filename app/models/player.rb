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

class Player < ApplicationRecord
  has_many :home_matches, class_name: "Match", foreign_key: "home_player_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_player_id"

  validates :first_name, presence: { message: "Please specify player's first name." }
  validates :last_name, presence: { message: "Please specify player's last name." }
  validates :country, presence: { message: "Please specify player's nationality." }
  validates :sex, presence: { message: "Please specify player's sex." }
  validates_inclusion_of :sex, in: ["female", "male"]

  default_scope -> { order("created_at ASC") }

  def age
    ((Time.current - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_date_of_birth
    date_of_birth.strftime("%-d %B %Y")
  end
end
