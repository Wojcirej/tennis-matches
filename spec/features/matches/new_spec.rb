require 'spec_config'

feature "Add new match page", type: :feature, js: true do
  given(:add_new_match_page) { Pages::Matches::New.new }
  given(:match_details_page) { Pages::Matches::Show.new }
  given(:matches_list_page) { Pages::Matches::Index.new }

  before do
    create(:tournament, :wimbledon)
    create(:player, :sharapova)
    create(:player, :serena)
    add_new_match_page.load
  end

  it_behaves_like "page with top main menu", :add_new_match_page

  scenario "has leading text explaining contents of the page" do
    expect(add_new_match_page).to have_lead
    expect(add_new_match_page.lead_text).to eq("Add new match")
  end

  scenario "after clicking 'Back' link takes to the matches list page" do
    add_new_match_page.back_link.click
    expect(matches_list_page).to be_displayed
  end

  scenario "allows to add valid match" do
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
    add_new_match_page.form.submit_button.click
    expect(match_details_page).to be_displayed
    expect(match_details_page).to have_content("Match was successfully created.")
    expect(match_details_page.lead_text).to eq("Wimbledon 2004 Final")
    expect(match_details_page.result_content).to eq("Maria Sharapova def. Serena Williams 6-1 6-4")
  end

  scenario "does not allow to add invalid match i.e. with two the same players or without score" do
    select("Maria Sharapova", from: 'match_home_player_id')
    select("Maria Sharapova", from: 'match_away_player_id')
    add_new_match_page.form.submit_button.click
    expect(page).to have_content("Match participants must be different!")
    expect(page).to have_content("Set 1 score for Maria Sharapova is missing.", count: 2)
    expect(page).to have_content("Set 2 score for Maria Sharapova is missing.", count: 2)
  end
end
