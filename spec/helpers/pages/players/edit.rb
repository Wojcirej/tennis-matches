module Pages
  module Players
    class Edit < SitePrism::Page
      set_url("players/{id}/edit")

      element :lead, 'p.lead'
      element :back_link, '.jumbotron a:nth-of-type(1)'
      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'
      section :form, PageSections::PlayersForm, 'form'

      def lead_text
        lead.text
      end
    end
  end
end
