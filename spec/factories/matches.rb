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
