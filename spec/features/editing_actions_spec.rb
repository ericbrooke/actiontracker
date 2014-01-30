require 'spec_helper'

feature "editing actions" do

	let!(:project) { FactoryGirl.create(:project) }
	let!(:action) {FactoryGirl.create(:action, project: project)}

	before do
		visit '/'
		click_link project.name
		click_link action.title
		click_link "Edit Action"
	end

	scenario "updating an action" do
		fill_in "Title", with: "Make it shiny"
		click_button "Update Action"

		expect(page).to have_content "Action has been updated."

		within("#action h2") do
			expect(page).to have_content("Make it shiny")
		end

		expect(page).to_not have_content action.title
	end

	scenario "updating an action with invalid information" do
		fill_in "Title", with: ""
		click_button "Update Action"

		expect(page).to have_content("Action has not been updated.")
	end
end
