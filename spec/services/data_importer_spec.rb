require 'spec_config'

RSpec.describe DataImporter do
  subject { described_class.new(file, data_type) }
  let(:file) { nil }
  let(:data_type) { nil }

  describe "#call" do

    context "when no supported file format" do

      before do
        allow_any_instance_of(described_class).to receive(:file_content_type).and_return("image/gif")
        allow_any_instance_of(described_class).to receive(:file_type).and_return("gif")
      end

      it "throws NotSupportedImportDataFormat exception" do
        expect { subject.call }.to raise_error(DataImporter::NotSupportedImportDataFormat)
      end
    end

    context "when CSV file uploaded" do

      before do
        allow_any_instance_of(described_class).to receive(:file_content_type).and_return("text/csv")
        allow_any_instance_of(described_class).to receive(:file_type).and_return("csv")
      end

      context "when 'data_type' specified as 'players'" do
        let(:data_type) { 'players' }

        it "delegates to Players::Importers::Csv class" do
          expect(Players::Importers::Csv).to receive(:call)
          subject.call
        end
      end

      context "when 'data_type' specified as 'tournaments'" do
        let(:data_type) { 'tournaments' }

        it "delegates to Tournaments::Importers::Csv class" do
          expect(Tournaments::Importers::Csv).to receive(:call)
          subject.call
        end
      end
    end
  end

  describe "#valid_content_type?" do

    context "when 'text/csv' file uploaded" do

      before do
        allow_any_instance_of(described_class).to receive(:file_content_type).and_return("text/csv")
        allow_any_instance_of(described_class).to receive(:file_type).and_return("csv")
      end

      it "returns true" do
        expect(subject.send(:valid_content_type?)).to be true
      end
    end

    context "when 'image/gif' file uploaded" do

      before do
        allow_any_instance_of(described_class).to receive(:file_content_type).and_return("image/gif")
        allow_any_instance_of(described_class).to receive(:file_type).and_return("gif")
      end

      it "returns false" do
        expect(subject.send(:valid_content_type?)).to be false
      end
    end
  end
end
