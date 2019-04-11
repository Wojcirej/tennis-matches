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
    first_name { "MyString" }
    last_name { "MyString" }
    country { "MyString" }
    date_of_birth { "2019-04-06" }
    born { "MyString" }
    sex { ["female", "male"].sample }
  end
end
