class ActionsController < ApplicationController

before_action :set_project
before_action :set_action, only: [:show, :edit, :update, :destroy]
before_action :require_signin!

	def new
		@action = @project.actions.build
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
	params.require(:foo).permit(:title, :description)
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

end
