require 'spec_helper'

feature 'Deleting actions' do

	let!(:user) {FactoryGirl.create(:user)}
	let!(:project) {FactoryGirl.create(:project)}
	let!(:action) { action =FactoryGirl.create(:action, project: project)
									action.update(user: user)
									action
	}

	before do
		sign_in_as!(user)
		visit '/'
		click_link project.name
		click_link action.title
  end

  scenario "deleteing an action" do
  	click_link "Delete Action"

  	expect(page).to have_content("Action has been deleted.")
  	expect(page.current_url).to eq(project_url(project))
  end
end

