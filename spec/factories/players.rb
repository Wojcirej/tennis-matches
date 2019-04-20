# == Schema Information
#
# Table name: players
#
#  id            :uuid             not null, primary key
#  first_name    :string           not null
#  last_name     :string           not null
#  country       :string           not null
#  date_of_birth :date
#  born          :string
#  sex           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :player do
    first_name { Faker::Movies::LordOfTheRings.unique.character }
    last_name { Faker::Name.unique.name }
    country { Enums::Countries.list.sample }
    date_of_birth { Faker::Date.unique.birthday(18, 40) }
    born { Faker::Movies::LordOfTheRings.unique.location }
    sex { ["female", "male"].sample }
  end
end
