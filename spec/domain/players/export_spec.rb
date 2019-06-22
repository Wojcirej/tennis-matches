require 'spec_config'

RSpec.describe Players::Export do
  subject { described_class.call(data) }
  let(:data) { create_list(:player, 2) }

  describe "#call" do
    let(:lines) { subject.split("\n") }
    let(:expected_headers) do
      %w(first_name last_name country date_of_birth born sex).join(",")
    end

    include_examples "csv exporters", "players"
  end
end
