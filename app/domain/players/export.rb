class Players::Export < CsvExporter

  def initialize(players)
    super(players)
  end

  def self.call(players)
    new(players).call
  end

  def set_headers
    @headers = %w(first_name last_name country date_of_birth born sex)
  end
end
