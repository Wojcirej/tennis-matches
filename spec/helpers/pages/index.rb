module Pages
  class Index < SitePrism::Page
    set_url("/")

    section :top_main_menu, PageSections::TopMainMenu, '#main-menu'
    element :lead, 'p.lead'

    def lead_text
      lead.text
    end
  end
end
