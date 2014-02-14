require 'spec_helper'

feature 'Creating Projects' do
	
	before (:each) do
		sign_in_as!(FactoryGirl.create(:admin_user))
	  visit '/'
    click_link 'New Project'
	end

	scenario "can create a project" do

		fill_in 'Name', with: 'actiontracker'
		fill_in 'Description', with: 'an app to track your projects'
		click_button 'Create Project'

		expect(page).to have_content('Project has been created.')
	
		project = Project.where(name: "actiontracker").first

		expect(page.current_url).to eql(project_url(project))

		title = "actiontracker - Projects - actiontracker"
		expect(page).to have_title(title)
	end
  
  scenario "can not create a project wthout a name" do

    click_button 'Create Project'

    expect(page).to have_content("Project has not been created.")
    expect(page).to have_content("Name can't be blank")
  end
end
