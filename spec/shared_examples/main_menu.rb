RSpec.shared_examples "page with top main menu" do |tested_page|

  context "top main menu" do

    scenario "has link to index page" do
      expect(send(tested_page).top_main_menu).to have_index_link
      expect(send(tested_page).top_main_menu.index_link[:href]).to eq("#{Capybara.app_host}")
    end

    scenario "has link to players list page" do
      expect(send(tested_page).top_main_menu).to have_players_link
      expect(send(tested_page).top_main_menu.players_link[:href]).to eq("#{Capybara.app_host}players")
    end

    scenario "has link to tournaments list page in Tournaments dropdown" do
      send(tested_page).top_main_menu.tournaments_dropdown.click
      expect(send(tested_page).top_main_menu).to have_all_tournaments_link
      expect(send(tested_page).top_main_menu.all_tournaments_link[:href]).to eq("#{Capybara.app_host}tournaments")
    end

    scenario "has link to only ATP tournaments list page in Tournaments dropdown" do
      send(tested_page).top_main_menu.tournaments_dropdown.click
      expect(send(tested_page).top_main_menu).to have_atp_tournaments_link
      expect(send(tested_page).top_main_menu.atp_tournaments_link[:href]).to eq("#{Capybara.app_host}tournaments/atp")
    end

    scenario "has link to only WTA tournaments list page in Tournaments dropdown" do
      send(tested_page).top_main_menu.tournaments_dropdown.click
      expect(send(tested_page).top_main_menu).to have_wta_tournaments_link
      expect(send(tested_page).top_main_menu.wta_tournaments_link[:href]).to eq("#{Capybara.app_host}tournaments/wta")
    end

    scenario "has link to only ITF tournaments list page in Tournaments dropdown" do
      send(tested_page).top_main_menu.tournaments_dropdown.click
      expect(send(tested_page).top_main_menu).to have_itf_tournaments_link
      expect(send(tested_page).top_main_menu.itf_tournaments_link[:href]).to eq("#{Capybara.app_host}tournaments/itf")
    end
  end
end
