module PageSections
  class MatchesForm < SitePrism::Section

    element :home_seed_selector, '#match_home_seed'
    element :home_player_selector, '#match_home_player_id'
    element :home_set_1_score_input, '#match_home_set_1_score'
    element :home_set_2_score_input, '#match_home_set_2_score'
    element :home_set_3_score_input, '#match_home_set_3_score'
    element :home_set_4_score_input, '#match_home_set_4_score'
    element :home_set_5_score_input, '#match_home_set_5_score'

    element :away_seed_selector, '#match_away_seed'
    element :away_player_selector, '#match_away_player_id'
    element :away_set_1_score_input, '#match_away_set_1_score'
    element :away_set_2_score_input, '#match_away_set_2_score'
    element :away_set_3_score_input, '#match_away_set_3_score'
    element :away_set_4_score_input, '#match_away_set_4_score'
    element :away_set_5_score_input, '#match_away_set_5_score'

    element :retirement_chekbox, '#match_retirement_true'
    element :set_1_tiebreak_score_input, '#match_tiebreak_set_1_score'
    element :set_2_tiebreak_score_input, '#match_tiebreak_set_2_score'
    element :set_3_tiebreak_score_input, '#match_tiebreak_set_3_score'
    element :set_4_tiebreak_score_input, '#match_tiebreak_set_4_score'
    element :set_5_tiebreak_score_input, '#match_tiebreak_set_5_score'

    element :tournament_selector, '#match_tournament_id'
    element :stage_selector, '#match_stage'
    element :match_date_input, '#match_date'

    element :submit_button, '.btn.btn-primary'
  end
end
