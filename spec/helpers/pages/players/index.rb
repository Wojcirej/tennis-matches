module Pages
  module Players
    class Index < SitePrism::Page
      set_url("/players")

      element :lead, 'p.lead'
      element :list, 'table'
      elements :all_players, 'tbody tr'
      elements :player_details_link, 'tbody tr td:nth-of-type(8) a:nth-of-type(1)'
      elements :edit_player_link, 'tbody tr td:nth-of-type(8) a:nth-of-type(2)'
      elements :delete_player_link, 'tbody tr td:nth-of-type(8) a:nth-of-type(3)'
      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'

      def lead_text
        lead.text
      end

      def first_name(index)
        all_players[index].find("td:nth-of-type(2)").text
      end

      def last_name(index)
        all_players[index].find("td:nth-of-type(3)").text
      end

      def date_of_birth(index)
        all_players[index].find("td:nth-of-type(4)").text
      end

      def born(index)
        all_players[index].find("td:nth-of-type(5)").text
      end

      def country(index)
        all_players[index].find("td:nth-of-type(6)").text
      end

      def age(index)
        all_players[index].find("td:nth-of-type(7)").text.to_i
      end

      def delete_player(index)
        accept_prompt do
          delete_player_link[index].click
        end
      end
    end
  end
end
