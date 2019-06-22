require 'spec_config'

def player_info_description
  "first name, last name, date of birth, city of birth, nationality and age"
end

feature "Players list page", type: :feature, js: true do
  given(:players_list_page) { Pages::Players::Index.new }
  given!(:players) { create_list(:player, 3) }

  before do
    players_list_page.load
  end

  it_behaves_like "page with top main menu", :players_list_page
  include_examples "export modal visibility", :players_list_page, "players"

  scenario "has leading text explaining contents of the page" do
    expect(players_list_page).to have_lead
    expect(players_list_page.lead_text).to eq("List of tennis players in database")
  end

  scenario "displays list of all players available in database" do
    expect(players_list_page).to have_player_rows
    expect(players_list_page.player_rows.size).to eq(players.size)
  end

  scenario "displays player's #{player_info_description}" do
    players.size.times do |index|
      expect(players_list_page.first_name(index)).to eq(players[index].first_name)
      expect(players_list_page.last_name(index)).to eq(players[index].last_name)
      expect(players_list_page.date_of_birth(index)).to eq(players[index].full_date_of_birth)
      expect(players_list_page.born(index)).to eq(players[index].born)
      expect(players_list_page.country(index)).to eq(players[index].country)
      expect(players_list_page.age(index)).to eq(players[index].age)
    end
  end

  scenario "displays links to details page, edit page and delete for each player" do
    expect(players_list_page).to have_player_details_link(count: players.size)
    expect(players_list_page).to have_edit_player_link(count: players.size)
    expect(players_list_page).to have_delete_player_link(count: players.size)
  end

  scenario "allows to delete player" do
    number_of_players_on_the_list_before_deletion = players_list_page.player_rows.size
    players_list_page.delete_player(0)
    expect(page).to have_content("Player #{players[0].full_name} has been deleted.")
    expect(players_list_page.player_rows.size).to eq(number_of_players_on_the_list_before_deletion - 1)
  end
end
