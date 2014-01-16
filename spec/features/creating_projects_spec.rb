require 'spec_helper'

feature 'Creating Projects' do
	scenario "can create a project" do
		visit '/'

		click_link 'New Project'

		fill_in 'Name', with: 'actiontracker'
		fill_in 'Description', with: 'an app to trcak your projects'
		click_button 'Create Project'

		expect(page).to have_content('Project has been created.')
	end
end
