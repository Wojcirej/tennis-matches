module PageSections
  class ExportModal < SitePrism::Section

    element :export_all_data_button, '.modal-body a:nth-of-type(1)'
    element :export_only_selected_data_button, '.modal-body a:nth-of-type(2)'
  end
end
