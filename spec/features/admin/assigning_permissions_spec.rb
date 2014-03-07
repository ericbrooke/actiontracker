require 'spec_helper'

feature "Assigning permissions" do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:action) { FactoryGirl.create(:action, project: project,
                                              user: user) }

  before do
    sign_in_as!(admin)

    click_link "Admin"
    click_link "Users"
    click_link user.email
    click_link "Permissions"
  end

  scenario "Viewing a project" do
    check_permission_box "view", project

    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    expect(page).to have_content(project.name)
  end

  scenario "Creating actions for a project" do
    check_permission_box "view", project
    check_permission_box "create_actions", project
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    click_link project.name
    click_link "New Action"
    fill_in "Title", with: "Shiny!"
    fill_in "Description", with: "Make it so!"
    click_button "Create"
    expect(page).to have_content("Action has been created.")
  end

  scenario "Updating a action for a project" do
    check_permission_box "view", project
    check_permission_box "edit_actions", project
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    click_link project.name
    click_link action.title
    click_link "Edit Action"
    fill_in "Title", with: "Really shiny!"
    click_button "Update Action"
    expect(page).to have_content("Action has been updated")
  end
  scenario "Deleting a action for a project" do
    check_permission_box "view", project
    check_permission_box "delete_actions", project
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    click_link project.name
    click_link action.title
    click_link "Delete Action"
    expect(page).to have_content("Action has been deleted.")
  end
end

