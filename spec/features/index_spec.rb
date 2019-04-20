require 'spec_config'

feature "Index page", type: :feature, js: true do
  given(:index_page) { Pages::Index.new }

  before do
    index_page.load
  end

  scenario "has main menu on the top of the page" do
    expect(index_page).to have_top_main_menu
  end

  scenario "has leading text saying 'Welcome'" do
    expect(index_page).to have_lead
    expect(index_page.lead_text).to eq("Welcome!")
  end

  it_behaves_like "page with top main menu", :index_page
end
