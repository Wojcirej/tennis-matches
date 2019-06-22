require 'spec_config'

RSpec.describe CsvExporter do
  subject { described_class.call(data) }
  let(:data) { build_list(:tournament, 2) }

  describe "#call" do

    it "throws 'No headers available' exception" do
      expect { subject }.to raise_error('No headers available')
    end
  end
end
