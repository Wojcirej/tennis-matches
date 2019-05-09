require 'spec_config'

feature "All tournaments list page", type: :feature, js: true do
  given(:tournaments_list_page) { Pages::Tournaments::List.new }

  shared_examples "common tournaments list contents and actions" do |tour_type|
    scenario "displays tournaments tour, category, name, country and city" do
      tournaments.size.times do |index|
        expect(tournaments_list_page.tour(index)).to eq(tournaments[index].tour)
        expect(tournaments_list_page.category(index)).to eq(tournaments[index].category)
        expect(tournaments_list_page.name(index)).to eq(tournaments[index].name)
        expect(tournaments_list_page.country(index)).to eq(tournaments[index].country)
        expect(tournaments_list_page.city(index)).to eq(tournaments[index].city)
      end
    end

    scenario "has leading text explaining contents of the page" do
      expect(tournaments_list_page).to have_lead
      expect(tournaments_list_page.lead_text).to eq("List of #{tour_type} tournaments in database")
    end

    scenario "displays list of #{tour_type} tournaments available in database" do
      expect(tournaments_list_page.tournament_rows.size).to eq(tournaments.size)
    end

    scenario "displays links to details page, edit page and delete for each tournament" do
      expect(tournaments_list_page).to have_tournament_details_link(count: tournaments.size)
      expect(tournaments_list_page).to have_edit_tournament_link(count: tournaments.size)
      expect(tournaments_list_page).to have_delete_tournament_link(count: tournaments.size)
    end

    scenario "allows to delete tournament" do
      number_of_tournaments_on_the_list_before_deletion = tournaments_list_page.tournament_rows.size
      tournaments_list_page.delete_tournament(0)
      expect(page).to have_content("Tournament #{tournaments[0].name} has been deleted.")
      expect(tournaments_list_page.tournament_rows.size).to eq(number_of_tournaments_on_the_list_before_deletion - 1)
    end
  end

  context "when no tour chosen" do
    given!(:tournaments) { create_list(:tournament, 3) }

    before do
      tournaments_list_page.load
    end

    it_behaves_like "page with top main menu", :tournaments_list_page
    include_examples "common tournaments list contents and actions", "all"

    scenario "allows to add new tournament via buttons under tournaments list" do
      expect(tournaments_list_page).to have_add_new_wta_tournament_button
      expect(tournaments_list_page).to have_add_new_atp_tournament_button
      expect(tournaments_list_page).to have_add_new_itf_tournament_button
    end
  end

  context "when ATP tour chosen" do
    given!(:tournaments) { create_list(:tournament, 3, :atp) }
    given!(:other_tournament) { create(:tournament, :wta) }

    before do
      tournaments_list_page.load(tour: "atp")
    end

    it_behaves_like "page with top main menu", :tournaments_list_page
    include_examples "common tournaments list contents and actions", "ATP"

    scenario "displays only ATP tournaments" do
      tournaments.size.times do |index|
        expect(tournaments_list_page.tour(index)).to eq("ATP")
      end
    end
  end

  context "when WTA tour chosen" do
    given!(:tournaments) { create_list(:tournament, 3, :wta) }
    given!(:other_tournament) { create(:tournament, :atp) }

    before do
      tournaments_list_page.load(tour: "wta")
    end

    it_behaves_like "page with top main menu", :tournaments_list_page
    include_examples "common tournaments list contents and actions", "WTA"

    scenario "displays only WTA tournaments" do
      tournaments.size.times do |index|
        expect(tournaments_list_page.tour(index)).to eq("WTA")
      end
    end
  end

  context "when ITF tour chosen" do
    given!(:tournaments) { create_list(:tournament, 3, :itf) }
    given!(:other_tournament) { create(:tournament, :wta) }

    before do
      tournaments_list_page.load(tour: "itf")
    end

    it_behaves_like "page with top main menu", :tournaments_list_page
    include_examples "common tournaments list contents and actions", "ITF"

    scenario "displays only ITF tournaments" do
      tournaments.size.times do |index|
        expect(tournaments_list_page.tour(index)).to eq("ITF")
      end
    end
  end
end
