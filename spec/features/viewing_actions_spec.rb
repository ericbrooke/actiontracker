require 'spec_helper'

feature "Viewing actions" do
	before do
		user = FactoryGirl.create(:user)

		sublime = FactoryGirl.create(:project, name: "sublime")
		action = FactoryGirl.create(:action, project: sublime, title: "Finish version 3", description: "yes actually")
		action.update(user: user)
		define_permission!(user, "view", sublime)

		chrome = FactoryGirl.create(:project, name: "chrome")
		action = FactoryGirl.create(:action, project: chrome, title: "stop being a processor hog", description: "and fix pepperflash")
		action.update(user: user)
		define_permission!(user, "view", chrome)

		sign_in_as!(user)
		visit "/"
	end

	scenario "Viewing actions for a given project" do
		click_link "sublime"

		expect(page).to have_content("Finish version 3")
		expect(page).to_not have_content('chickens are go')

		click_link "Finish version 3"

		within("#action h2") do
			expect(page).to have_content("Finish version 3")
		end

		expect(page).to have_content("yes actually")
	end
end
