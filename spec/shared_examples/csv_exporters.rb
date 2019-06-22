RSpec.shared_examples "csv exporters" do |data_type|

  it "includes all required headers for #{data_type} data" do
    expect(lines.first).to eq(expected_headers)
  end

  it "returns all passed data in csv format" do
    expect(lines.size).to eq(data.size + 1)
  end
end

RSpec.shared_examples "export modal visibility" do |tested_page, data_type|

  scenario "allows to export either all available #{data_type} or just selected ones to CSV file" do
    expect(send(tested_page).export_button).to be_visible
    send(tested_page).export_button.click
    expect(send(tested_page).export_modal).to be_visible
    expect(send(tested_page).export_modal.export_all_data_button).to be_visible
    expect(send(tested_page).export_modal.export_only_selected_data_button).to be_visible
  end
end

RSpec.shared_examples "endpoint responding with csv content" do

  before do
    get path
  end

  it "responds with HTTP 200 status" do
    expect(response.status).to eq(200)
  end

  it "responds with content type 'text/csv'" do
    expect(response.headers['Content-type']).to eq("text/csv")
  end
end
