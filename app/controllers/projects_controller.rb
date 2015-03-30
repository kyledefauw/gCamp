class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create, :destroy]
  before_action :ensure_signed_in
  before_action :ensure_member_of_project, except: [:index, :new, :create, :destroy]
  before_action :ensure_project_has_owner, only: [:edit, :update]

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
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    flash[:notice] = 'Project was successfully deleted'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
