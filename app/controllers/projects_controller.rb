class ProjectsController < ApplicationController

  before_filter :ensure_signed_in

  def index
    @projects = current_user.projects.all
    # memberships = current_user.memberships
    # @projects = []
    # memberships.each do |membership|
    #   @projects << membership.project
    # end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @membership = @project.memberships.create!(user_id: current_user.id, role: 1)
      flash[:notice] = "Project was successfully created"
      redirect_to project_tasks_path(@project, @task)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated"
      redirect_to project_path
    else
      render :edit
    end
  end

  def destroy
    Project.destroy(params[:id])
    flash[:notice] = "Project was successfully deleted"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end



end
