module Pages
  module Matches
    class Show < SitePrism::Page
      set_url("/matches{/id}")

      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'
      element :lead, 'p.lead'
      element :result, 'p:nth-of-type(3)'
      element :edit_link, '.jumbotron a:nth-of-type(1)'
      element :back_link, '.jumbotron a:nth-of-type(2)'

      def lead_text
        lead.text
      end

      def result_content
        result.text
      end
    end
  end
end
