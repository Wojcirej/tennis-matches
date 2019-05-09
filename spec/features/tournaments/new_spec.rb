require 'spec_config'

feature "Add new tournament page", type: :feature, js: true do
  given(:add_new_tournament_page) { Pages::Tournaments::New.new }
  given(:tournaments_list_page) { Pages::Tournaments::List.new }

  before do
    add_new_tournament_page.load(query: { tour: tour })
  end

  shared_examples "add new tournament common actions" do
    scenario "has leading text explaining contents of the page" do
      expect(add_new_tournament_page).to have_lead
      expect(add_new_tournament_page.lead_text).to eq("Add new #{tour} tournament")
    end

    scenario "after clicking 'Back' link takes to the tournaments list page" do
      add_new_tournament_page.back_link.click
      expect(tournaments_list_page).to be_displayed
    end

    scenario "displays errors after trying to create new tournament without name and city" do
      add_new_tournament_page.form.submit_button.click
      expect(add_new_tournament_page).to have_content("Please specify name of the tournament.")
      expect(add_new_tournament_page).to have_content("Please specify host city of the tournament.")
    end
  end

  context "when ATP tournament" do
    given(:tour) { "ATP" }
    given(:expected_tournament_categories) { expected_atp_tournament_categories }

    it_behaves_like "page with top main menu", :add_new_tournament_page
    include_examples "tournaments form actions", :add_new_tournament_page, "ATP", "add"
    include_examples "add new tournament common actions"
  end

  context "when WTA tournament" do
    given(:tour) { "WTA" }
    given(:expected_tournament_categories) { expected_wta_tournament_categories }

    it_behaves_like "page with top main menu", :add_new_tournament_page
    include_examples "tournaments form actions", :add_new_tournament_page, "WTA", "add"
    include_examples "add new tournament common actions"
  end

  context "when ITF tournament" do
    given(:tour) { "ITF" }
    given(:expected_tournament_categories) { expected_itf_tournament_categories }

    it_behaves_like "page with top main menu", :add_new_tournament_page
    include_examples "tournaments form actions", :add_new_tournament_page, "ITF", "add"
    include_examples "add new tournament common actions"
  end
end
