class ActionsController < ApplicationController

before_action :set_project
before_action :set_action, only: [:show, :edit, :update, :destroy]

	def new
		@action = @project.actions.build
	end

	def create
		@action = @project.actions.build(action_params)
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


private

  def action_params
  	params.require(:foo).permit(:title, :description)
  end

  def set_project
  	@project = Project.find(params[:project_id])
  end

  def set_action
  	@action = @project.actions.find(params[:id])
  end

end
