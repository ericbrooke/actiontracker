require 'spec_helper'

feature "Creating Actions" do

	before do
	  project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    @email = user.email
  
    visit '/'
    click_link project.name
    click_link "New Action"
    message = "You need to sign in or sign up before continuing."
    expect(page).to have_content(message)

    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"

    click_link project.name
    click_link "New Action"
  end
  
	scenario "Creating an action" do
		fill_in "Title", with: "Really important!"
		fill_in "Description", with: "loads of test in this box"
		click_button "Create Action"

		expect(page).to have_content("Action has been created.")

		within '#action #author' do
			expect(page).to have_content("Created by #{@email}")
		end
	end

	scenario "Creating an action with nothing filled in" do

		click_button "Create Action"

		expect(page).to have_content("Action has not been created.")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
	end

	scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "it sucks"
    click_button "Create Action"

    expect(page).to have_content("Action has not been created.")
    expect(page).to have_content("Description is too short")
  end

end
