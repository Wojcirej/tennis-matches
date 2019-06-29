require 'spec_config'

RSpec.describe Players::Importers::Csv do
  subject { described_class.call(file) }

  describe "#call" do

    after do
      FileUtils.rm_rf(Dir['spec/fixtures/*'])
    end

    include_examples "csv import", "players"
  end
end
