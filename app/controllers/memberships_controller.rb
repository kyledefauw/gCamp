class MembershipsController < ApplicationController
  before_action :find_and_set_project
  before_filter :ensure_signed_in

  def index
    @memberships = @project.memberships
    @project_name = @project.name
    @membership = @project.memberships.new
  end

  def new
    @membership = @project.memberships.new
  end

  def create
    @membership =  @project.memberships.new(membership_params)

    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully created"
      redirect_to project_memberships_path(@project, @membership)
    else
      render :index
    end
  end

  def show
    @membership = @project.memberships.find(params[:id])
  end

  def edit
    @membership = @project.memberships.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])

    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path(@project)
    flash[:notice] = membership.user.full_name + " was successfully removed."
  end

  private

  def membership_params
    params.require(:membership).permit(:role, :user_id, :project_id)
  end

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

end
