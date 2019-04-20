require 'spec_config'

feature "Add new player page", type: :feature, js: true do
  given(:add_new_player_page) { Pages::Players::New.new }
  given(:player_details_page) { Pages::Players::Show.new }
  given(:players_list_page) { Pages::Players::Index.new }

  before do
    add_new_player_page.load
  end

  it_behaves_like "page with top main menu", :add_new_player_page
  include_examples "players form actions", :add_new_player_page, "create new"

  scenario "has leading text explaining contents of the page" do
    expect(add_new_player_page).to have_lead
    expect(add_new_player_page.lead_text).to eq("Add new tennis player")
  end

  scenario "after clicking 'Back' link takes to the players list page" do
    add_new_player_page.back_link.click
    expect(players_list_page).to be_displayed
  end

  scenario "displays errors after trying to create new player without first name, last name and picking sex" do
    add_new_player_page.form.submit_button.click
    expect(add_new_player_page).to have_content("Please specify player's first name.")
    expect(add_new_player_page).to have_content("Please specify player's last name.")
    expect(add_new_player_page).to have_content("Please specify player's sex.")
  end
end
