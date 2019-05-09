module PageSections
  class TournamentsForm < SitePrism::Section

    element :tournament_category_selector, '#tournament_category'
    elements :tournament_categories, '#tournament_category option'
    element :name_input, '#tournament_name'
    element :country_selector, '#tournament_country'
    element :city_input, '#tournament_city'
    element :submit_button, '.btn.btn-primary'

    def tournament_categories_options_list
      tournament_categories.map(&:text)
    end

    def category_value
      tournament_category_selector.value
    end

    def name_value
      name_input.value
    end

    def country_value
      country_selector.value
    end

    def city_value
      city_input.value
    end
  end
end
