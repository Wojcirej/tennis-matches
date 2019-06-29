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

RSpec.shared_examples "import modal visibility" do |tested_page, data_type|

  scenario "allows to import #{data_type} data via uploaded CSV file" do
    expect(send(tested_page).import_button).to be_visible
    send(tested_page).import_button.click
    expect(send(tested_page).import_modal).to be_visible
    expect(send(tested_page).import_modal.upload_input).to be_visible
    expect(send(tested_page).import_modal.submit_button).to be_visible
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

RSpec.shared_examples "csv import" do |data_type|

  model_class = data_type.capitalize.singularize.constantize

  context "when data_type = '#{data_type}'" do
    let(:data_type) { data_type }
    let(:collection) { build_list("#{data_type.singularize}", 3) }
    let(:file) { prepare_sample_csv_file(collection, data_type) }

    it "creates as much new #{model_class} records as lines without headers in imported csv file" do
      expect { subject }.to change { model_class.count }.by(3)
    end
  end

  context "when potentially 1000 records to create" do
    require 'benchmark'
    let(:data_type) { data_type }
    let(:collection) { build_list("#{data_type.singularize}", 1000) }
    let(:file) { prepare_sample_csv_file(collection, data_type) }

    it "performs under 2 seconds" do
      expect(
        Benchmark.realtime { subject }
      ).to be < 2.seconds
    end

    it "creates all 1000 records" do
      expect { subject }.to change { model_class.count }.by(1000)
    end
  end
end
