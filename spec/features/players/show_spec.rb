require 'spec_config'

feature "Player details page", type: :feature, js: true do
  given(:player_details_page) { Pages::Players::Show.new }
  given(:players_list_page) { Pages::Players::Index.new }
  given(:edit_player_page) { Pages::Players::Edit.new }
  given(:player) { create(:player) }

  before do
    player_details_page.load(id: player.id)
  end

  it_behaves_like "page with top main menu", :player_details_page

  scenario "displays lead text with player's first and last name" do
    expect(player_details_page.lead_text).to eq(player.full_name)
  end

  scenario "displays details of player like date of birth, age and nationality" do
    aggregate_failures "player details" do
      expect(player_details_page.date_of_birth).to eq(player.full_date_of_birth)
      expect(player_details_page.age).to eq(player.age)
      expect(player_details_page.country).to eq(player.country)
    end
  end

  scenario "allows to go back to the list of players page or edit player from the bottom menu" do
    expect(player_details_page).to have_edit_link
    expect(player_details_page).to have_back_link
  end

  scenario "after clicking 'Back' link takes to the players list page" do
    player_details_page.back_link.click
    expect(players_list_page).to be_displayed
  end

  scenario "after clicking 'Edit' link takes to the edit player page" do
    player_details_page.edit_link.click
    expect(edit_player_page).to be_displayed
  end
end
