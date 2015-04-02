class MembershipsController < ApplicationController
  before_action :find_and_set_project
  before_action :ensure_signed_in
  before_action :ensure_more_than_one_owner, only: [:update, :destroy]
  before_action :verify_project_owner_or_admin, except: [:index, :new, :update, :destory]

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
      redirect_to project_memberships_path(@project)
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
    redirect_to projects_path
    flash[:notice] = membership.user.full_name + " was successfully removed."
  end

  private

  def membership_params
    params.require(:membership).permit(:role, :user_id, :project_id)
  end

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

  def ensure_more_than_one_owner
  @membership = @project.memberships.find(params[:id])
  if Project.find(params[:project_id]).memberships.map(&:role).count("Owner") == 1 && @membership.role == "Owner"
    flash[:error] = "Projects must have at least one owner"
    redirect_to project_memberships_path(@membership.project_id)
    end
  end

end
