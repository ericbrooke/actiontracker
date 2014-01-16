require 'spec_helper'

feature 'Creating Projects' do
	scenario "can create a project" do
		visit '/'

		click_link 'New Project'

		fill_in 'Name', with: 'actiontracker'
		fill_in 'Description', with: 'an app to track your projects'
		click_button 'Create Project'

		expect(page).to have_content('Project has been created.')
	
		project = Project.where(name: "actiontracker").first

		expect(page.current_url).to eql(project_url(project))

		title = "actiontracker - Projects - actiontracker"
		expect(page).to have_title(title)
	end

end
