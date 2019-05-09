# == Schema Information
#
# Table name: tournaments
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  country    :string           not null
#  city       :string           not null
#  category   :string           not null
#  tour       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :tournament do
    name { "MyString" }
    country { "MyString" }
    city { "MyString" }
    tour { "ATP" }
    category { Tournaments::Enums::AtpTournamentCategories.values.sample }

    trait :atp do
      tour { "ATP" }
      category { Tournaments::Enums::AtpTournamentCategories.values.sample }
    end

    trait :wta do
      tour { "WTA" }
      category { Tournaments::Enums::WtaTournamentCategories.values.sample }
    end

    trait :itf do
      tour { "ITF" }
      category { Tournaments::Enums::ItfTournamentCategories.values.sample }
    end
  end
end
