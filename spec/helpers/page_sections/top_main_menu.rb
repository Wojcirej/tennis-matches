module PageSections
  class TopMainMenu < SitePrism::Section

    element :brand, '#brand-link'
    element :index_link, '#index-link'
    element :players_link, '#players-link'
    element :tournaments_dropdown, '#navbarDropdown'
    element :atp_tournaments_link, '#atp-tournaments-link'
    element :wta_tournaments_link, '#wta-tournaments-link'
    element :itf_tournaments_link, '#itf-tournaments-link'
    element :all_tournaments_link, '#all-tournaments-link'
  end
end
