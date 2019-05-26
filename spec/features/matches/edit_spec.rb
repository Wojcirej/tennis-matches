require 'spec_config'

feature "Edit match page", type: :feature, js: true do
  given(:edit_match_page) { Pages::Matches::Edit.new }
  given(:match_details_page) { Pages::Matches::Show.new }
  given(:matches_list_page) { Pages::Matches::Index.new }
  given!(:match) { create(:match, :wimbledon_2004_women_final) }

  before do
    edit_match_page.load(id: match.id)
  end

  it_behaves_like "page with top main menu", :edit_match_page

  scenario "has leading text explaining contents of the page" do
    expect(edit_match_page).to have_lead
    expect(edit_match_page.lead_text).to eq("Edit Wimbledon 2004 Final")
  end

  scenario "after clicking 'Back' link takes to the matches list page" do
    edit_match_page.back_link.click
    expect(matches_list_page).to be_displayed
  end

  scenario "after clicking 'Show' link takes to the match details page" do
    edit_match_page.details_link.click
    expect(match_details_page).to be_displayed(id: match.id)
  end

  scenario "allows edit match with valid data" do
    select("1", from: 'match_home_seed')
    select("Serena Williams", from: 'match_home_player_id')
    fill_in('match_home_set_1_score', with: "1")
    fill_in('match_home_set_2_score', with: "4")
    select("13", from: 'match_away_seed')
    select("Maria Sharapova", from: 'match_away_player_id')
    fill_in('match_away_set_1_score', with: "6")
    fill_in('match_away_set_2_score', with: "6")
    select("Wimbledon", from: "Tournament")
    select("Final", from: "Stage")
    fill_in("Date", with: "2004-07-03")
    edit_match_page.form.submit_button.click
    expect(match_details_page).to be_displayed
    expect(match_details_page).to have_content("Match was successfully updated.")
    expect(match_details_page.lead_text).to eq("Wimbledon 2004 Final")
    expect(match_details_page.result_content).to eq("Maria Sharapova def. Serena Williams 6-1 6-4")
  end

  scenario "does not allow to edit with invalid data i.e. with two the same players" do
    select("Maria Sharapova", from: 'match_home_player_id')
    select("Maria Sharapova", from: 'match_away_player_id')
    edit_match_page.form.submit_button.click
    expect(page).to have_content("Match participants must be different!")
  end
end
