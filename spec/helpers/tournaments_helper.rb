module TournamentsHelper

  def expected_wta_tournament_categories
    ["Grand Slam", "Premier Mandatory", "Premier 5", "Premier", "International",
    "Challenger Tour"]
  end

  def expected_atp_tournament_categories
    ["Grand Slam", "Masters1000", "500", "250", "Challenger Tour"]
  end

  def expected_itf_tournament_categories
    ["Grand Slam", "Futures", "Hopman Cup"]
  end
end
