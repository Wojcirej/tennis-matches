module Pages
  module Tournaments
    class List < SitePrism::Page
      set_url("/tournaments{/tour}")

      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'
      element :lead, 'p.lead'
      elements :tournament_rows, 'tbody tr'
      elements :tours, 'tbody tr td:nth-of-type(2)'
      elements :categories, 'tbody tr td:nth-of-type(3)'
      elements :names, 'tbody tr td:nth-of-type(4)'
      elements :countries, 'tbody tr td:nth-of-type(5)'
      elements :cities, 'tbody tr td:nth-of-type(6)'
      elements :tournament_details_link, 'tbody tr td:nth-of-type(7) a:nth-of-type(1)'
      elements :edit_tournament_link, 'tbody tr td:nth-of-type(7) a:nth-of-type(2)'
      elements :delete_tournament_link, 'tbody tr td:nth-of-type(7) a:nth-of-type(3)'
      element :add_new_wta_tournament_button, '.btn-group a:nth-of-type(1)'
      element :add_new_atp_tournament_button, '.btn-group a:nth-of-type(2)'
      element :add_new_itf_tournament_button, '.btn-group a:nth-of-type(3)'
      element :export_button, '.btn-group button:first-of-type'
      section :export_modal, PageSections::ExportModal, '#export-modal'
      element :import_button, '.btn-group button:nth-of-type(2)'
      section :import_modal, PageSections::ImportModal, '#import-modal'

      def tour(index)
        tours[index].text
      end

      def category(index)
        categories[index].text
      end

      def name(index)
        names[index].text
      end

      def country(index)
        countries[index].text
      end

      def city(index)
        cities[index].text
      end

      def delete_tournament(index)
        accept_prompt do
          delete_tournament_link[index].click
        end
      end

      def lead_text
        lead.text
      end
    end
  end
end
