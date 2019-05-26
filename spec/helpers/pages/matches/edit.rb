module Pages
  module Matches
    class Edit < SitePrism::Page
      set_url('/matches/{id}/edit')

      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'
      element :lead, 'p.lead'
      section :form, PageSections::MatchesForm, 'form'
      element :details_link, '.jumbotron a:nth-of-type(1)'
      element :back_link, '.jumbotron a:nth-of-type(2)'

      def lead_text
        lead.text
      end
    end
  end
end
