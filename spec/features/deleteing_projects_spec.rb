require 'spec_helper'

feature "Deleting projects" do
	
	scenario "Deleting a project" do
	  FactoryGirl.create(:project, name: "Ralph")

	  visit "/"
	  click_link "Ralph"
	  click_link "Delete Project"

	  expect(page).to have_content("Project has been destroyed.")

	  visit "/"
	  expect(page).to have_no_content("Ralph")
	end

end