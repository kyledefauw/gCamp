class TasksController < ApplicationController
  before_action :find_and_set_project
  before_filter :ensure_signed_in
  before_action :limit_action

  def index
    @tasks = @project.tasks
    @name = @project.name
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task =  @project.tasks.new(task_params)

    if @task.save
      flash[:notice] = "Task was successfully created"

      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to project_task_path(@project, @task)
    else
      render :edit
    end
  end

  def destroy
    task = @project.tasks.find(params[:id])
    task.destroy
    flash[:notice] = "Task was successfully deleted"
    redirect_to project_tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:description, :complete, :date, :project_id)
  end

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

  def limit_action
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(project_id: @project.id))
      flash[:danger] = "You do not have access"
      redirect_to projects_path
    end
  end

end
