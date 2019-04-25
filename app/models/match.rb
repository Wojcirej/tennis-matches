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

class Match < ApplicationRecord
  belongs_to :home_player, class_name: "Player"
  belongs_to :away_player, class_name: "Player"
  belongs_to :tournament

  validates :home_player_id, presence: { message: "Please specify participant of the match." }
  validates :away_player_id, presence: { message: "Please specify participant of the match." }
  validates :tournament_id, presence: { message: "Please specify tournament at which match has been played." }
  validates :stage, presence: { message: "Please specify stage of tournament." }
  validates :date, presence: { message: "Please specify date of the match." }
  validates_inclusion_of :stage, in: Enums::TournamentStages.values
  validates_numericality_of :home_set_1_score, :home_set_2_score, :home_set_3_score,
  :home_set_4_score, :home_set_5_score, :away_set_1_score, :away_set_2_score,
  :away_set_3_score, :away_set_4_score, :away_set_5_score,
  greater_than_or_equal_to: 0, less_than_or_equal_to: 7, allow_nil: true

  validates :home_set_1_score, :home_set_2_score, :away_set_1_score,
  :away_set_2_score, presence: true, unless: :retirement?

  default_scope -> { order("created_at ASC") }

  def retirement?
    retirement
  end

  def brief_summary
    "[#{tournament.name} #{date.year} #{stage}] [#{home_seed}] #{home_player.full_name} v. [#{away_seed}] #{away_player.full_name}"
  end
end
