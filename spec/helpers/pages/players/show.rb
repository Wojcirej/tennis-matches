module Pages
  module Players
    class Show < SitePrism::Page
      set_url("/players{/id}")

      element :lead, 'p.lead'
      element :date_of_birth_with_age, 'p:nth-of-type(3)'
      element :nationality, 'p:nth-of-type(4)'
      element :edit_link, '.jumbotron a:nth-of-type(1)'
      element :back_link, '.jumbotron a:nth-of-type(2)'
      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'

      def lead_text
        lead.text
      end

      def date_of_birth
        date_of_birth_with_age.text.split("(").first.gsub("Born: ", "").squish
      end

      def age
        date_of_birth_with_age.text.split("(").last.gsub("age ", "").to_i
      end

      def country
        nationality.text.gsub("Nationality: ", "")
      end
    end
  end
end
