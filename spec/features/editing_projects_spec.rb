require 'spec_helper'

feature "Editing Projects" do
	
	before do
		sign_in_as!(FactoryGirl.create(:admin_user))
	  FactoryGirl.create(:project, name: "Chicken")
		visit "/"
		click_link "Chicken"
		click_link "Edit Project"
	end


	scenario "Updating project" do
		fill_in "Name", with: "Chickens are go"

		click_button "Update Project"

		expect(page).to have_content("Project has been updated.")
	end

	scenario "Updating a project with no name" do
	  fill_in "Name", with: ""
	  click_button "Update Project"
	  expect(page).to have_content("Project has not been updated.")
	end

end