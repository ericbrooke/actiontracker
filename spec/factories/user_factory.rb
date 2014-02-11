FactoryGirl.define do
  factory :user do
    name  "username"
    password "a password"
    password_confirmation "a password"
    email "sample@example.com"
  end
end