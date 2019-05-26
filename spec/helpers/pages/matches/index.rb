module Pages
  module Matches
    class Index < SitePrism::Page
      set_url("/matches")

      section :top_main_menu, PageSections::TopMainMenu, '#main-menu'
      element :lead, 'p.lead'
      element :list, 'table'
      elements :match_rows, 'tbody tr'
      elements :match_details_link, 'tbody tr td:nth-of-type(3) a:nth-of-type(1)'
      elements :edit_match_link, 'tbody tr td:nth-of-type(3) a:nth-of-type(2)'
      elements :delete_match_link, 'tbody tr td:nth-of-type(3) a:nth-of-type(3)'

      def lead_text
        lead.text
      end

      def delete_match(index)
        accept_prompt do
          delete_match_link[index].click
        end
      end
    end
  end
end
