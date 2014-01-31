require 'spec_helper'

feature 'Deleting actions' do

	let!(:project) {FactoryGirl.create(:project)}
	let!(:action) {FactoryGirl.create(:action, project: project)}

	before do
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

