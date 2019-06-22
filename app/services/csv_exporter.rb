require 'csv'
class CsvExporter

  attr_reader :data, :headers

  def initialize(data)
    @data = data
    @headers = nil
  end

  def self.call(data)
    new(data).call
  end

  def call
    raise("No data available") if data.nil?
    set_headers
    CSV.generate(headers: true) do |csv|
      csv << headers

      data.each do |record|
        csv << headers.map { |attr| record.send(attr) }
      end
    end
  end

  private
  def set_headers
    raise("No headers available")
  end
end
