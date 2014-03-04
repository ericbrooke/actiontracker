require 'spec_helper'

describe ActionsController do

	let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:action) { FactoryGirl.create(:action,
                                    project: project,
                                    user: user) }

  context "standard users" do
    it "cannot access a action for a project" do
      sign_in(user)
      get :show, :id => action.id, :project_id => project.id

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking " +
                                   "for could not be found.")
    end

	  context "with permission to view the project" do
		  before do
		    sign_in(user)
		    define_permission!(user, "view", project)
		  end

		  def cannot_create_actions!
		    response.should redirect_to(project)
		    message = "You cannot create actions on this project."
		    flash[:alert].should eql(message)
		  end

			def cannot_update_actions!
			  expect(response).to redirect_to(project)
			  expect(flash[:alert]).to eql("You cannot edit actions " \
			                               "on this project.")
			end

			it "cannot edit a action without permission" do
			  get :edit, { project_id: project.id, id: action.id }
			  cannot_update_actions!
			end

			it "cannot update a action without permission" do
			  put :update, { project_id: project.id,
			                 id: action.id,
			                 action: {}
			               }
			  cannot_update_actions!
			end

			it "cannot delete a action without permission" do
			  delete :destroy, { project_id: project.id, id: action.id }

			  expect(response).to redirect_to(project)
			  message = "You cannot delete actions from this project."
			  expect(flash[:alert]).to eql(message)
			end


		  it "cannot begin to create a action" do
		    get :new, project_id: project.id
		    cannot_create_actions!
		  end

		  it "cannot create a action without permission" do
		    post :create, project_id: project.id
		    cannot_create_actions!
		  end
		end
  end
end
