module Web::CommonExceptionHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from DataImporter::NotSupportedImportDataFormat, with: :not_supported_import_data_format

    def not_supported_import_data_format(error)
      redirect_to send("#{controller_name}_path"), alert: "Import aborted - not supported type of data uploaded."
    end
  end
end
