require 'spec_config'

feature "All matches list page", type: :feature, js: true do
  given(:matches_list_page) { Pages::Matches::Index.new }
  given!(:matches) { create_list(:match, 3) }

  before do
    matches_list_page.load
  end

  it_behaves_like "page with top main menu", :matches_list_page
  include_examples "export modal visibility", :matches_list_page, "matches"

  scenario "has leading text explaining contents of the page" do
    expect(matches_list_page).to have_lead
    expect(matches_list_page.lead_text).to eq("Available matches in database")
  end

  scenario "displays list of matches available in database" do
    expect(matches_list_page.match_rows.size).to eq(matches.size)
  end

  scenario "displays links to details page, edit page and delete for each match" do
    expect(matches_list_page).to have_match_details_link(count: matches.size)
    expect(matches_list_page).to have_edit_match_link(count: matches.size)
    expect(matches_list_page).to have_delete_match_link(count: matches.size)
  end

  scenario "allows to delete match" do
    number_of_matches_on_the_list_before_deletion = matches_list_page.match_rows.size
    matches_list_page.delete_match(0)
    expect(page).to have_content("Match has been deleted.")
    expect(matches_list_page.match_rows.size).to eq(number_of_matches_on_the_list_before_deletion - 1)
  end
end
