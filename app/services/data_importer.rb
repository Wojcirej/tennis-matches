class DataImporter
  class NotSupportedImportDataFormat < StandardError; end

  def initialize(file, data_type)
    @file = file
    @data_type = data_type
  end

  def self.call(file, data_type)
    new(file, data_type).call
  end

  def call
    raise NotSupportedImportDataFormat unless valid_content_type?
    set_importer_class
    @importer_class.call(file)
  end

  private
  attr_reader :file, :data_type

  def valid_content_type?
    permissible_content_types.include?(file_content_type)
  end

  def permissible_content_types
    ["text/csv"]
  end

  def file_content_type
    file.content_type
  end

  def file_type
    file.content_type.split("/").last
  end

  def set_importer_class
    @importer_class = "#{data_type.capitalize}::Importers::#{file_type.capitalize}".constantize
  end
end
