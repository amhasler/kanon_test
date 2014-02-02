FactoryGirl.define do
  factory :user do
    name     "Adam H"
    email    "amhasler@gmail.com"
    password "porkchop"
    password_confirmation "porkchop"
  end
end