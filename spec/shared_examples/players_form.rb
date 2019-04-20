RSpec.shared_examples "players form actions" do |tested_page, action|

  let(:result) { action == "edit" ? "updated" : "created" }

  scenario "Allows #{action} female player and then see details page" do
    Timecop.freeze(DateTime.new(2019, 4, 19))
    fill_in('First name', with: 'Maria')
    fill_in('Last name', with: 'Sharapova')
    fill_in('Date of birth', with: '1987-04-19')
    fill_in('Born', with: 'Nyagan')
    select('Russia', from: 'Country')
    send(tested_page).form.female_sex_option.click
    send(tested_page).form.submit_button.click
    expect(player_details_page).to be_displayed
    expect(player_details_page).to have_content("Player has been #{result} successfully.")
    expect(player_details_page.lead_text).to eq("Maria Sharapova")
    expect(player_details_page.date_of_birth.squish).to eq("19 April 1987")
    expect(player_details_page.age).to eq(32)
    Timecop.return
    expect(player_details_page.country).to eq("Russia")
  end

  scenario "Allows #{action} male player and then see details page" do
    Timecop.freeze(DateTime.new(2019, 4, 19))
    fill_in('First name', with: 'Rafael')
    fill_in('Last name', with: 'Nadal')
    fill_in('Date of birth', with: '1986-06-03')
    fill_in('Born', with: 'Manacor')
    select('Spain', from: 'Country')
    send(tested_page).form.male_sex_option.click
    send(tested_page).form.submit_button.click
    expect(player_details_page).to be_displayed
    expect(player_details_page).to have_content("Player has been #{result} successfully.")
    expect(player_details_page.lead_text).to eq("Rafael Nadal")
    expect(player_details_page.date_of_birth).to eq("3 June 1986")
    expect(player_details_page.age).to eq(32)
    Timecop.return
    expect(player_details_page.country).to eq("Spain")
  end
end
