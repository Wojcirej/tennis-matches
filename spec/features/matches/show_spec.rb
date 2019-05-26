require 'spec_config'

feature "Match details page", type: :feature, js: true do
  given(:match_details_page) { Pages::Matches::Show.new }
  given(:matches_list_page) { Pages::Matches::Index.new }
  given(:match) { Matches::Decorators::Details.new(create(:match, :wimbledon_2004_women_final)) }

  before do
    match_details_page.load(id: match.id)
  end

  it_behaves_like "page with top main menu", :match_details_page

  scenario "has leading text explaining contents of the page" do
    expect(match_details_page).to have_lead
    expect(match_details_page.lead_text).to eq("Wimbledon 2004 Final")
  end

  scenario "displays result of the match" do
    expect(match_details_page.result_content).to eq("Maria Sharapova def. Serena Williams 6-1 6-4")
  end

  scenario "allows to go back to the list of matches page or edit match from the bottom menu" do
    expect(match_details_page).to have_edit_link
    expect(match_details_page).to have_back_link
  end

  scenario "after clicking 'Back' link takes to the matches list page" do
    match_details_page.back_link.click
    expect(matches_list_page).to be_displayed
  end
end
