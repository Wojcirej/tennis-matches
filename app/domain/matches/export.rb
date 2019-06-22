class Matches::Export < CsvExporter

  def initialize(matches)
    super(matches)
  end

  def self.call(matches)
    new(matches).call
  end

  def set_headers
    @headers = %w(home_player_name away_player_name tournament_name stage date
    home_seed away_seed home_set_1_score home_set_2_score home_set_3_score
    home_set_4_score home_set_5_score away_set_1_score away_set_2_score
    away_set_3_score away_set_4_score away_set_5_score tiebreak_set_1_score
    tiebreak_set_2_score tiebreak_set_3_score tiebreak_set_4_score tiebreak_set_5_score)
  end
end
