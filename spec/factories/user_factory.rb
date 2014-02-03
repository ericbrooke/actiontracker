FactoryGirl.define do
  factory :user do
    name  "Example name"
    password "a password"
    password_confirmation "a password"
    email "an example email"
  end
end