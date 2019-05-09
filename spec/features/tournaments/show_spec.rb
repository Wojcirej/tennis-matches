require 'spec_config'

feature "Tournament details page", type: :feature, js: true do
  given(:tournament_details_page) { Pages::Tournaments::Show.new }
  given(:tournaments_list_page) { Pages::Tournaments::List.new }
  given(:tournament) { create(:tournament) }

  before do
    tournament_details_page.load(id: tournament.id)
  end

  it_behaves_like "page with top main menu", :tournament_details_page

  scenario "displays lead text with tournament's name included" do
    expect(tournament_details_page.lead_text).to eq("Details about #{tournament.name} tournament")
  end

  scenario "displays details of tournament like name, country, city, category and tour it belongs to" do
    aggregate_failures "tournament details" do
      expect(tournament_details_page.displayed_name).to eq(tournament.name)
      expect(tournament_details_page.displayed_country).to eq(tournament.country)
      expect(tournament_details_page.displayed_city).to eq(tournament.city)
      expect(tournament_details_page.displayed_category).to eq(tournament.category)
      expect(tournament_details_page.displayed_tour).to eq(tournament.tour)
    end
  end

  scenario "allows to go back to the list of tournaments page or edit tournament from the bottom menu" do
    expect(tournament_details_page).to have_edit_link
    expect(tournament_details_page).to have_back_link
  end

  scenario "after clicking 'Back' link takes to the tournaments list page" do
    tournament_details_page.back_link.click
    expect(tournaments_list_page).to be_displayed
  end
end
