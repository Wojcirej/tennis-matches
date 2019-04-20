require 'spec_config'

feature "Edit existing player page", type: :feature, js: true do
  given(:edit_player_page) { Pages::Players::Edit.new }
  given(:player_details_page) { Pages::Players::Show.new }
  given(:players_list_page) { Pages::Players::Index.new }
  given(:player) { create(:player) }

  before do
    edit_player_page.load(id: player.id)
  end

  it_behaves_like "page with top main menu", :edit_player_page
  include_examples "players form actions", :edit_player_page, "edit"

  scenario "has leading text explaining contents of the page" do
    expect(edit_player_page).to have_lead
    expect(edit_player_page.lead_text).to eq("Edit details about #{player.full_name}")
  end

  scenario "after clicking 'Back' link takes to the players list page" do
    edit_player_page.back_link.click
    expect(players_list_page).to be_displayed
  end

  scenario "has pre-filled form with details of edited player" do
    expect(edit_player_page.form.first_name_value).to eq(player.first_name)
    expect(edit_player_page.form.last_name_value).to eq(player.last_name)
    expect(edit_player_page.form.date_of_birth_value).to eq(player.date_of_birth)
    expect(edit_player_page.form.born_value).to eq(player.born)
    expect(edit_player_page.form.country_value).to eq(player.country)
    expect(edit_player_page.form.send("#{player.sex}_sex_option_checked?")).to be true
  end

  scenario "Displays errors after trying to edit player by erasing first name and last name" do
    fill_in('First name', with: '')
    fill_in('Last name', with: '')
    edit_player_page.form.submit_button.click
    expect(edit_player_page).to have_content("Please specify player's first name.")
    expect(edit_player_page).to have_content("Please specify player's last name.")
  end
end
