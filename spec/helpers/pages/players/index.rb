module Pages
  module Players
    class Index < SitePrism::Page
      set_url("/players")

      element :lead, 'p.lead'
      element :list, 'table'
      elements :player_rows, 'tbody tr'
      elements :first_names, 'tbody tr td:nth-of-type(2)'
      elements :last_names, 'tbody tr td:nth-of-type(3)'
      elements :date_of_births, 'tbody tr td:nth-of-type(4)'
      elements :borns, 'tbody tr td:nth-of-type(5)'
      elements :countries, 'tbody tr td:nth-of-type(6)'
      elements :ages, 'tbody tr td:nth-of-type(7)'
      elements :player_details_link, 'tbody tr td:nth-of-type(8) a:nth-of-type(1)'
      elements :edit_player_link, 'tbody tr td:nth-of-type(8) a:nth-of-type(2)'
      elements :delete_player_link, 'tbody tr td:nth-of-type(8) a:nth-of-type(3)'
      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'

      def lead_text
        lead.text
      end

      def first_name(index)
        first_names[index].text
      end

      def last_name(index)
        last_names[index].text
      end

      def date_of_birth(index)
        player_rows[index].find("td:nth-of-type(4)").text
      end

      def born(index)
        player_rows[index].find("td:nth-of-type(5)").text
      end

      def country(index)
        player_rows[index].find("td:nth-of-type(6)").text
      end

      def age(index)
        player_rows[index].find("td:nth-of-type(7)").text.to_i
      end

      def delete_player(index)
        accept_prompt do
          delete_player_link[index].click
        end
      end
    end
  end
end
