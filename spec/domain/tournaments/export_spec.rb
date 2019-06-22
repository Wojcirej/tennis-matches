require 'spec_config'

RSpec.describe Tournaments::Export do
  subject { described_class.call(data) }
  let(:data) { create_list(:tournament, 2) }

  describe "#call" do
    let(:lines) { subject.split("\n") }
    let(:expected_headers) do
      %w(name country city category tour).join(",")
    end

    include_examples "csv exporters", "tournaments"
  end
end
