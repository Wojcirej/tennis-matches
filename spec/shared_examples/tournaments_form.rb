RSpec.shared_examples "tournaments form actions" do |tested_page, tour, action|

  let(:result) { action == "edit" ? "updated" : "created" }

  scenario "has only tournament categories applicable to #{tour} matches" do
    expect(send(tested_page).form.tournament_categories_options_list).to eq(expected_tournament_categories)
  end

  scenario "allows to #{action} new #{tour} tournament" do
    select("Grand Slam", from: "Category")
    fill_in('Name', with: "US Open")
    select("United States", from: "Country")
    fill_in('City', with: "New York")
    send(tested_page).form.submit_button.click
    expect(page).to have_content("Tournament was successfully #{result}.")
  end
end
