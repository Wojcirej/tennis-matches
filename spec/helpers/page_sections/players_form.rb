module PageSections
  class PlayersForm < SitePrism::Section

    element :first_name_input, '#player_first_name'
    element :last_name_input, '#player_last_name'
    element :date_of_birth_picker, '#player_date_of_birth'
    element :born_input, '#player_born'
    element :country_selector, '#player_country'
    element :male_sex_option, '#player_sex_male'
    element :female_sex_option, '#player_sex_female'
    element :submit_button, '.btn.btn-primary'

    def first_name_value
      first_name_input.value
    end

    def last_name_value
      last_name_input.value
    end

    def date_of_birth_value
      Date.parse(date_of_birth_picker.value)
    end

    def born_value
      born_input.value
    end

    def country_value
      country_selector.value
    end

    def male_sex_option_checked?
      male_sex_option.checked?
    end

    def female_sex_option_checked?
      female_sex_option.checked?
    end
  end
end
