class Tournaments::Export < CsvExporter

  def initialize(tournaments)
    super(tournaments)
  end

  def self.call(tournaments)
    new(tournaments).call
  end

  def set_headers
    @headers = %w(name country city category tour)
  end
end
