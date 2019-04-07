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
