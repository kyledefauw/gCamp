class MembershipsController < ApplicationController
  before_action :find_and_set_project
  before_action :ensure_signed_in
  before_action :verify_project_owner, except: [:index, :new, :update, :destroy]

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
    if owner_count(@project) == 1 && @membership.role == 1
        flash[:danger] = "Projects must have at least one owner"
        redirect_to project_memberships_path(@project.id)
      elsif @membership.update(membership_params)
        redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
     if owner_count(@project) == 1 && @membership.role == 1
       flash[:danger] = "Projects must have at least one owner"
       redirect_to project_memberships_path(@project.id)
     else
       membership = Membership.find(params[:id])
       membership.destroy
       flash[:notice] = "#{membership.user.full_name} was successfully removed"
       redirect_to projects_path
     end
   end

  private

  def membership_params
    params.require(:membership).permit(:role, :user_id, :project_id)
  end

  def find_and_set_project
    @project = Project.find(params[:project_id])
  end

end
