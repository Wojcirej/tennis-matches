module Pages
  module Tournaments
    class Show < SitePrism::Page
      set_url("/tournaments{/id}")

      element :lead, 'p.lead'
      element :name, 'p:nth-of-type(3)'
      element :country, 'p:nth-of-type(4)'
      element :city, 'p:nth-of-type(5)'
      element :category, 'p:nth-of-type(6)'
      element :tour, 'p:nth-of-type(7)'
      element :edit_link, '.jumbotron a:nth-of-type(1)'
      element :back_link, '.jumbotron a:nth-of-type(2)'
      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'

      def lead_text
        lead.text
      end

      def displayed_name
        name.text.split(":").last.squish
      end

      def displayed_country
        country.text.split(":").last.squish
      end

      def displayed_city
        city.text.split(":").last.squish
      end

      def displayed_category
        category.text.split(":").last.squish
      end

      def displayed_tour
        tour.text.split(":").last.squish
      end
    end
  end
end
