class ActionsController < ApplicationController

before_action :require_signin!
before_action :set_project
before_action :set_action, only: [:show, :edit, :update, :destroy]
before_action :authorize_create!, only: [:new,:create]
before_action :authorize_update!, only: [:edit, :update]
before_action :authorize_delete!, only: :destroy

	def new
		@action = @project.actions.build
    @action.assets.build
	end

	def create
		@action = @project.actions.build(action_params)
    @action.user = current_user

		if @action.save
			flash[:notice] = "Action has been created."
			redirect_to [@project, @action]
		else
			flash[:alert] = "Action has not been created."
			render "new"
		end
	end
  
  def edit
  end

  def update
  	if @action.update(action_params)
  		flash[:notice] ="Action has been updated."
  		redirect_to [@project, @action]
  	else
  		flash[:alert] = "Action has not been updated."
  		render "edit"
  	end
  end

  def destroy
  	@action.destroy
  	flash[:notice] = "Action has been deleted."
  	redirect_to @project
  end

private

  def action_params
	 params.require(:foo).permit(:title, :description, assets_attributes: [:asset])
  end

  def set_project
    @project = Project.for(current_user).find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking " +
                  "for could not be found."
    redirect_to root_path
  end

  def set_action
  	@action = @project.actions.find(params[:id])
  end

  def authorize_create!
    if !current_user.admin? && cannot?("create actions".to_sym, @project)
      flash[:alert] = "You cannot create actions on this project."
      redirect_to @project
    end
  end

  def authorize_update!
    if !current_user.admin? && cannot?("edit actions".to_sym, @project)
      flash[:alert] = "You cannot edit actions on this project."
      redirect_to @project
    end
  end

  def authorize_delete!
    if !current_user.admin? && cannot?(:"delete actions", @project)
      flash[:alert] = "You cannot delete actions from this project."
      redirect_to @project
    end
  end

end
