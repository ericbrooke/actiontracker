require 'spec_helper'

feature "profile page" do
	scenario "viewing" do
		user = FactoryGirl.create(:user)

		visit user_path(user)

		expect(page).to have_content(user.name)
		expect(page).to have_content(user.email)
	end
end

feature "editing users" do
  scenario "updating a project" do
  	user = FactoryGirl.create(:user)

  	visit user_path(user)
  	click_link "Edit Profile"

  	fill_in "Username", with: "new_username"
  	fill_in "Email", with: "new_email"
  	click_button "Update Profile"

  	expect(page).to have_content("Profile has been updated.")

  end
end

