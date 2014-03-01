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
  end
end
