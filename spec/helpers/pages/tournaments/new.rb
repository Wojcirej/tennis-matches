module Pages
  module Tournaments
    class New < SitePrism::Page
      set_url('/tournaments/new{?query*}')

      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'
      element :lead, 'p.lead'
      section :form, PageSections::TournamentsForm, 'form'
      element :back_link, '.jumbotron a:nth-of-type(1)'

      def lead_text
        lead.text
      end
    end
  end
end
