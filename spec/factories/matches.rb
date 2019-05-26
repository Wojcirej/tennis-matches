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

FactoryBot.define do
  factory :match do
    association :home_player, factory: :player, strategy: :create
    association :away_player, factory: :player, strategy: :create
    association :tournament, factory: :tournament, strategy: :create
    stage { Tournaments::Enums::TournamentStages.values.sample }
    date { "2019-04-20" }
    home_seed { "MyString" }
    away_seed { "MyString" }
    home_set_1_score { 7 }
    home_set_2_score { 6 }
    home_set_3_score { nil }
    home_set_4_score { nil }
    home_set_5_score { nil }
    away_set_1_score { 5 }
    away_set_2_score { 3 }
    away_set_3_score { nil }
    away_set_4_score { nil }
    away_set_5_score { nil }
    tiebreak_set_1_score { nil }
    tiebreak_set_2_score { nil }
    tiebreak_set_3_score { nil }
    tiebreak_set_4_score { nil }
    tiebreak_set_5_score { nil }
    retirement { false }

    trait :retirement do
      retirement { true }
    end

    trait :wimbledon_2004_women_final do
      home_player { create(:player, first_name: "Serena", last_name: "Williams") }
      away_player { create(:player, first_name: "Maria", last_name: "Sharapova") }
      tournament { create(:tournament, name: "Wimbledon") }
      stage { "F" }
      date { "2004-07-03" }
      home_seed { "1" }
      away_seed { "13" }
      home_set_1_score { 1 }
      home_set_2_score { 4 }
      away_set_1_score { 6 }
      away_set_2_score { 6 }
      retirement { false }
    end

    trait :home_two_zero_winner do
      home_set_1_score { 7 }
      away_set_1_score { 5 }
      home_set_2_score { 6 }
      away_set_2_score { 3 }
    end

    trait :home_two_zero_winner_with_tie_break do
      home_set_1_score { 7 }
      away_set_1_score { 6 }
      home_set_2_score { 6 }
      away_set_2_score { 3 }
      tiebreak_set_1_score { "8-6" }
    end

    trait :away_two_zero_winner do
      home_set_1_score { 5 }
      away_set_1_score { 7 }
      home_set_2_score { 3 }
      away_set_2_score { 6 }
    end
  end
end
