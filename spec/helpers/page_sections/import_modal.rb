module PageSections
  class ImportModal < SitePrism::Section

    element :upload_input, "input[type='file']"
    element :submit_button, '.modal-body input[type=submit]'
  end
end
