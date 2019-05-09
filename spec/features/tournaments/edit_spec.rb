require 'spec_config'

feature "Edit tournament page", type: :feature, js: true do
  given(:edit_tournament_page) { Pages::Tournaments::Edit.new }
  given(:tournaments_list_page) { Pages::Tournaments::List.new }

  before do
    edit_tournament_page.load(id: tournament.id, query: { tour: tournament.tour })
  end

  shared_examples "edit tournament common actions" do

    scenario "has leading text explaining contents of the page" do
      expect(edit_tournament_page).to have_lead
      expect(edit_tournament_page.lead_text).to eq("Edit #{tournament.name} tournament")
    end

    scenario "after clicking 'Back' link takes to the tournaments list page" do
      edit_tournament_page.back_link.click
      expect(tournaments_list_page).to be_displayed
    end

    scenario "has pre-filled form with details of edited player" do
      expect(edit_tournament_page.form.name_value).to eq(tournament.name)
      expect(edit_tournament_page.form.category_value).to eq(tournament.category)
      expect(edit_tournament_page.form.city_value).to eq(tournament.city)
      expect(edit_tournament_page.form.country_value).to eq(tournament.country)
    end

    scenario "displays errors after trying to update name and city with empty values" do
      fill_in('Name', with: '')
      fill_in('City', with: '')
      edit_tournament_page.form.submit_button.click
      expect(edit_tournament_page).to have_content("Please specify name of the tournament.")
      expect(edit_tournament_page).to have_content("Please specify host city of the tournament.")
    end
  end

  context "when ATP tournament" do
    given(:tournament) { create(:tournament, :atp, country: "Australia") }
    given(:expected_tournament_categories) { expected_atp_tournament_categories }

    it_behaves_like "page with top main menu", :edit_tournament_page
    include_examples "tournaments form actions", :edit_tournament_page, "ATP", "edit"
    include_examples "edit tournament common actions"
  end

  context "when WTA tournament" do
    given(:tournament) { create(:tournament, :wta, country: "Australia") }
    given(:expected_tournament_categories) { expected_wta_tournament_categories }

    it_behaves_like "page with top main menu", :edit_tournament_page
    include_examples "tournaments form actions", :edit_tournament_page, "WTA", "edit"
    include_examples "edit tournament common actions"
  end

  context "when ITF tournament" do
    given(:tournament) { create(:tournament, :itf, country: "Australia") }
    given(:expected_tournament_categories) { expected_itf_tournament_categories }

    it_behaves_like "page with top main menu", :edit_tournament_page
    include_examples "tournaments form actions", :edit_tournament_page, "ITF", "edit"
    include_examples "edit tournament common actions"
  end
end
